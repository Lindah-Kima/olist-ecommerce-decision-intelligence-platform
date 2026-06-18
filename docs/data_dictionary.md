# Data Dictionary: Olist E-Commerce Analytics Platform

This document outlines the schema, relationships, and business context of the Olist Brazilian E-Commerce dataset. The data represents ~100,000 anonymized orders placed between 2016 and 2018.  Table definitions below describe the **Silver Layer** (cleaned/normalized) schema, including primary/foreign keys and expected data types after casting from the raw CSVs.

## 1. Customers (`olist_customers_dataset`)

Contains customer location data and unique identity resolution.

| Column Name                 | Silver Data Type | Key Type | Business Description                                                                                  |
| --------------------------- | ---------------: | :------: | ------------------------------------------------------------------------------------------------------ |
| `customer_id`               | `VARCHAR`        | **PK**   | Order-scoped customer ID. Each checkout generates a new `customer_id` even if the buyer is the same person. This is the transactional key for the order-to-customer link. |
| `customer_unique_id`        | `VARCHAR`        |          | Persistent ID for the actual physical customer (anonymized). Used to track repeat buyers across orders.        |
| `customer_zip_code_prefix`  | `VARCHAR`        | **FK**   | First 5 digits of the customer’s ZIP code (links to `olist_geolocation_dataset`). Identifies delivery region.   |
| `customer_city`             | `VARCHAR`        |          | Customer’s city name (delivery location).                                                            |
| `customer_state`            | `VARCHAR`        |          | Customer’s state (two-letter abbreviation).                                                         |

## 2. Orders (`olist_orders_dataset`)

The central transactional hub mapping customers to their purchase lifecycle timestamps.

| Column Name                    | Silver Data Type | Key Type | Business Description                                                                             |
| ------------------------------ | ---------------: | :------: | ------------------------------------------------------------------------------------------------- |
| `order_id`                     | `VARCHAR`        | **PK**   | Unique identifier for the order.                                                    |
| `customer_id`                  | `VARCHAR`        | **FK**   | Links to `olist_customers_dataset.customer_id`, identifying who placed the order.    |
| `order_status`                 | `VARCHAR`        |          | Current status of the order (e.g., `delivered`, `shipped`, `canceled`).             |
| `order_purchase_timestamp`     | `TIMESTAMP`      |          | Timestamp when the customer completed checkout.                                   |
| `order_approved_at`            | `TIMESTAMP`      |          | Timestamp when payment for the order was approved.                                 |
| `order_delivered_carrier_date` | `TIMESTAMP`      |          | When the package was handed to the logistics carrier.                                              |
| `order_delivered_customer_date`| `TIMESTAMP`      |          | When the order was delivered to the customer.                                                   |
| `order_estimated_delivery_date`| `TIMESTAMP`      |          | Estimated delivery date provided at order time.                                   |

## 3. Order Items (`olist_order_items_dataset`)

Line-item details for every product in an order.

| Column Name           | Silver Data Type | Key Type | Business Description                                                                                  |
| --------------------- | ---------------: | :------: | ------------------------------------------------------------------------------------------------------ |
| `order_id`            | `VARCHAR`        | **FK**   | Links to `olist_orders_dataset.order_id`.                                                             |
| `order_item_id`       | `INTEGER`        | **PK**   | Sequential index of the item within the order (1, 2, …). Identifies the line in multi-item orders.   |
| `product_id`          | `VARCHAR`        | **FK**   | Links to `olist_products_dataset.product_id`.                                                        |
| `seller_id`           | `VARCHAR`        | **FK**   | Links to `olist_sellers_dataset.seller_id`, the merchant fulfilling this item.                        |
| `shipping_limit_date` | `TIMESTAMP`      |          | Deadline by which the seller must ship this item.                                                    |
| `price`               | `NUMERIC`        |          | Unit price of the product (in BRL).                                                                   |
| `freight_value`       | `NUMERIC`        |          | Shipping fee for this item.                                                                          |

## 4. Order Payments (`olist_order_payments_dataset`)

Records of how each order was paid (supports split payments).

| Column Name             | Silver Data Type | Key Type | Business Description                                                                                  |
| ----------------------- | ---------------: | :------: | ------------------------------------------------------------------------------------------------------ |
| `order_id`              | `VARCHAR`        | **FK**   | Links to the order in `olist_orders_dataset`.                                                        |
| `payment_sequential`    | `INTEGER`        | **PK**   | Sequence number for the payment record (e.g., if a customer split payment into multiple entries).     |
| `payment_type`          | `VARCHAR`        |          | Method used (e.g., `credit_card`, `boleto`, `voucher`).                                               |
| `payment_installments`  | `INTEGER`        |          | Number of installments chosen (for credit card payments).                                             |
| `payment_value`         | `NUMERIC`        |          | Amount paid in this payment transaction (BRL).                                                       |

## 5. Order Reviews (`olist_order_reviews_dataset`)

Customer feedback and satisfaction scores post-delivery.

| Column Name              | Silver Data Type | Key Type | Business Description                                                                                  |
| ------------------------ | ---------------: | :------: | ------------------------------------------------------------------------------------------------------ |
| `review_id`              | `VARCHAR`        | **PK**   | Unique ID for the review.                                                                            |
| `order_id`               | `VARCHAR`        | **FK**   | Links to the reviewed order in `olist_orders_dataset`.                                                |
| `review_score`           | `INTEGER`        |          | Customer rating (1–5) for the order experience.                                                       |
| `review_comment_title`   | `TEXT`           |          | Optional review title (Portuguese).                                                                  |
| `review_comment_message` | `TEXT`           |          | Optional written review (Portuguese).                                                                |
| `review_creation_date`   | `TIMESTAMP`      |          | When the review request was sent to the customer.                                                    |
| `review_answer_timestamp`| `TIMESTAMP`      |          | When the customer submitted the review.                                                             |

## 6. Products (`olist_products_dataset`)

Catalog of products with category and dimension attributes.

| Column Name                    | Silver Data Type | Key Type | Business Description                                                                                  |
| ------------------------------ | ---------------: | :------: | ------------------------------------------------------------------------------------------------------ |
| `product_id`                   | `VARCHAR`        | **PK**   | Unique identifier for each product.                                                                  |
| `product_category_name`        | `VARCHAR`        | **FK**   | Category name in Portuguese (links to `product_category_name_translation`).                           |
| `product_name_lenght`          | `INTEGER`        |          | Number of characters in the product’s name (note the misspelling “lenght” is as in source CSV).       |
| `product_description_lenght`   | `INTEGER`        |          | Number of characters in the product’s description.                                                   |
| `product_photos_qty`           | `INTEGER`        |          | How many photos are in the product listing.                                                         |
| `product_weight_g`             | `NUMERIC`        |          | Weight of the product (in grams).                                                                   |
| `product_length_cm`            | `NUMERIC`        |          | Length of the packaged product (cm).                                                                |
| `product_height_cm`            | `NUMERIC`        |          | Height of the packaged product (cm).                                                                |
| `product_width_cm`             | `NUMERIC`        |          | Width of the packaged product (cm).                                                                 |

## 7. Sellers (`olist_sellers_dataset`)

Merchant fulfillment locations.

| Column Name               | Silver Data Type | Key Type | Business Description                                                                                  |
| ------------------------- | ---------------: | :------: | ------------------------------------------------------------------------------------------------------ |
| `seller_id`               | `VARCHAR`        | **PK**   | Unique identifier for the merchant.                                                                  |
| `seller_zip_code_prefix`  | `VARCHAR`        | **FK**   | First 5 digits of the seller’s ZIP code (links to geolocation for the seller).                         |
| `seller_city`             | `VARCHAR`        |          | City where the seller is located.                                                                    |
| `seller_state`            | `VARCHAR`        |          | State of the seller.                                                                                 |

## 8. Geolocation (`olist_geolocation_dataset`)

Spatial mapping of Brazilian zip codes to coordinates.

| Column Name                 | Silver Data Type | Key Type | Business Description                                                                                  |
| --------------------------- | ---------------: | :------: | ------------------------------------------------------------------------------------------------------ |
| `geolocation_zip_code_prefix` | `VARCHAR`      | **PK**   | First 5 digits of the ZIP code.                                                                      |
| `geolocation_lat`           | `NUMERIC`        |          | Latitude coordinate.                                                                                 |
| `geolocation_lng`           | `NUMERIC`        |          | Longitude coordinate.                                                                                |
| `geolocation_city`          | `VARCHAR`        |          | City name.                                                                                           |
| `geolocation_state`         | `VARCHAR`        |          | State abbreviation.                                                                                 |

## 9. Category Translation (`product_category_name_translation`)

Localization mapping for product categories.

| Column Name                   | Silver Data Type | Key Type | Business Description                                                                                  |
| ----------------------------- | ---------------: | :------: | ------------------------------------------------------------------------------------------------------ |
| `product_category_name`       | `VARCHAR`        | **PK**   | Category name in Portuguese.                                                                        |
| `product_category_name_english` | `VARCHAR`      |          | Category name translated to English.                                                                |

---

### Strategic Engineering Notes & Relational Traps

1. **The Identity Trap (`customers`)**: Each new order gets a new `customer_id` even if the buyer is the same person. In other words, `customer_id` is not a stable customer key. To track true returning customers and compute lifetime value, queries must use `customer_unique_id`, which persists across multiple orders.

2. **Multi-Seller Orders**: One order can contain items from multiple sellers. Freight and revenue must be computed at the item level, not the order level, because different rows may be fulfilled by different merchants. For example, a single `order_id` can have several `order_item_id` rows with different `seller_id`. Analytics should aggregate on each item’s seller and freight accordingly.

3. **Cartesian Join (Fan-Out) Risk**: Directly joining `order_items` to `order_payments` on `order_id` causes a row explosion (many-to-many join). For instance, an order with 3 items and 1 payment would duplicate that payment three times, inflating revenue 3×. Similarly, multiple payments and items can produce a Cartesian product, severely distorting sums. The solution is to pre-aggregate payments (and/or items) per order before joining to the order fact.

4. **Unstructured Text Fields**: Review text fields contain raw user input (e.g. `review_comment_message`) with possible newlines, trailing spaces, or backslashes. In practice, the ETL uses functions like `NULLIF(..., '')` and `TRIM(...)` to sanitize these fields. For example, one implementation strips whitespace from `review_comment_message` and handles empty strings explicitly, ensuring clean insertion into the data warehouse.

**Sources:** Schema details and definitions are drawn from the official Olist dataset documentation and community resources. The traps and design notes reflect best practices established in Olist data engineering projects.