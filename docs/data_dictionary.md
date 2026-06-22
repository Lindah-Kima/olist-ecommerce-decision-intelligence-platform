# Data Dictionary: Olist E-Commerce Decision Intelligence Platform

This document outlines the schema, relationships, and business context of the Olist Brazilian E-Commerce dataset. The data represents ~100,000 anonymized orders placed between 2016 and 2018. Table definitions below describe the **Silver Layer** (cleaned/normalized) schema, including expected data types and transformations after casting from the raw Bronze layer.

## Data Dictionary: Olist Silver Layer

### 1. Customers (`silver.customers`)

| Column Name | Data Type | Business Description |
| --- | --- | --- |
| `customer_id` | `VARCHAR` | Order-scoped customer ID. Each checkout generates a new ID even if the buyer is the same person. Transactional key for the order link. |
| `customer_unique_id` | `VARCHAR` | Persistent identifier for the actual physical customer (anonymized). Used to track repeat buyers and calculate Customer Lifetime Value (CLV). |
| `zip_code` | `VARCHAR` | Trimmed and standardized 5-digit ZIP code prefix identifying the customer's delivery region. |
| `city` | `VARCHAR` | Standardized and title-cased customer city name. |
| `state` | `VARCHAR` | Uppercase two-letter state abbreviation. |

### 2. Orders (`silver.orders`)

| Column Name | Data Type | Business Description |
| --- | --- | --- |
| `order_id` | `VARCHAR` | Unique identifier for the order. Central transactional hub. |
| `customer_id` | `VARCHAR` | Foreign key linking to `silver.customers.customer_id`. |
| `order_status` | `VARCHAR` | Lowercase current state of the order (e.g., `delivered`, `shipped`, `canceled`). |
| `purchase_ts` | `TIMESTAMP` | Normalized timestamp when the customer completed checkout. |
| `approved_ts` | `TIMESTAMP` | Normalized timestamp when the order payment was approved. |
| `carrier_delivered_ts` | `TIMESTAMP` | Timestamp when the package was handed over to the logistics carrier. Critical for isolating carrier transit times. |
| `delivered_ts` | `TIMESTAMP` | Normalized timestamp when the order was successfully delivered to the customer. |
| `estimated_delivery_ts` | `TIMESTAMP` | Estimated delivery date provided to the customer at order placement. Serves as the target baseline for SLA compliance and delay modeling. |
| `is_date_missing_flag` | `BOOLEAN` | Data quality audit flag. Set to `TRUE` if the order status is marked 'delivered' but the `delivered_ts` is missing/null. |

### 3. Order Items (`silver.order_items`)

| Column Name | Data Type | Business Description |
| --- | --- | --- |
| `order_id` | `VARCHAR` | Foreign key linking to `silver.orders.order_id`. |
| `order_item_id` | `INT` | Sequential index of the item within a specific order (1, 2, etc.) to identify individual lines in multi-item orders. |
| `product_id` | `VARCHAR` | Foreign key linking to `silver.products.product_id`. |
| `seller_id` | `VARCHAR` | Foreign key linking to `silver.sellers.seller_id` (the merchant fulfilling this specific item). |
| `shipping_limit_ts` | `TIMESTAMP` | Merchant shipping deadline. The date by which the seller must hand the product over to the carrier; used to measure seller fulfillment velocity. |
| `price` | `NUMERIC(10,2)` | Unit price of the product in Brazilian Real (BRL). |
| `freight_val` | `NUMERIC(10,2)` | Shipping fee allocated to this specific item line in BRL. |

### 4. Order Payments (`silver.order_payments`)

| Column Name | Data Type | Business Description |
| --- | --- | --- |
| `order_id` | `VARCHAR` | Foreign key linking to `silver.orders.order_id`. |
| `payment_sequential` | `INT` | Sequence number for split payments (e.g., if an order is paid using multiple payment methods or vouchers). |
| `payment_type` | `VARCHAR` | Lowercase payment method used (e.g., `credit_card`, `boleto`, `voucher`). |
| `payment_installments` | `INT` | Number of installments selected for credit card payments. |
| `payment_val` | `NUMERIC(10,2)` | Amount paid in this specific payment transaction entry (BRL). |

### 5. Order Reviews (`silver.order_reviews`)

| Column Name | Data Type | Business Description |
| --- | --- | --- |
| `review_id` | `VARCHAR` | Unique identifier for the customer review. |
| `order_id` | `VARCHAR` | Foreign key linking to `silver.orders.order_id`. |
| `review_score` | `INT` | Customer satisfaction rating on a scale from 1 to 5. |
| `comment` | `TEXT` | Sanitized text feedback from the customer. Empty strings default to `'no_comment'`. |

### 6. Products (`silver.products`)

| Column Name | Data Type | Business Description |
| --- | --- | --- |
| `product_id` | `VARCHAR` | Unique identifier for the product. |
| `category` | `VARCHAR` | Lowercase category name standardized in Portuguese. Missing data defaults to `'uncategorized'`. |
| `product_name_length` | `INT` | Character length of the product name. Cleaned column mapping from source. |
| `product_description_length` | `INT` | Character length of the product description text. |
| `weight_g` | `INT` | Product weight in grams. Core predictive feature for logistics modeling and freight cost calculations. |
| `length_cm` | `INT` | Packaged product length in centimeters. Used for physical dimension analysis. |
| `height_cm` | `INT` | Packaged product height in centimeters. |
| `width_cm` | `INT` | Packaged product width in centimeters. |

### 7. Sellers (`silver.sellers`)

| Column Name | Data Type | Business Description |
| --- | --- | --- |
| `seller_id` | `VARCHAR` | Unique identifier for the merchant. |
| `zip_code` | `VARCHAR` | Trimmed and standardized 5-digit ZIP code prefix of the merchant's operational location. |
| `city` | `VARCHAR` | Standardized and title-cased city name where the seller is located. |
| `state` | `VARCHAR` | Uppercase two-letter state abbreviation of the seller. |

### 8. Geolocation (`silver.geolocation`)

| Column Name | Data Type | Business Description |
| --- | --- | --- |
| `zip_code` | `VARCHAR` | Primary key prefix capturing geographic spatial grouping. |
| `lat` | `NUMERIC(9,6)` | Precise latitude coordinate. |
| `lng` | `NUMERIC(9,6)` | Precise longitude coordinate. |

### 9. Category Translation (`silver.category_translation`)

| Column Name | Data Type | Business Description |
| --- | --- | --- |
| `category_pt` | `VARCHAR` | Trimmed, lowercase category name in Portuguese. Links directly to `silver.products.category`. |
| `category_en` | `VARCHAR` | Trimmed, lowercase category translation in English for localized analytical reporting. |

---

### Engineering Notes & Relational Traps

1. **The Identity Trap (`customers`)**: Each new order gets a new `customer_id` even if the buyer is the same person. In other words, `customer_id` is not a stable customer key. To track true returning customers and compute lifetime value, queries must use `customer_unique_id`, which persists across multiple orders.

2. **Multi-Seller Orders**: One order can contain items from multiple sellers. Freight and revenue must be computed at the item level, not the order level, because different rows may be fulfilled by different merchants. For example, a single `order_id` can have several `order_item_id` rows with different `seller_id`. Analytics should aggregate on each item’s seller and freight accordingly.

3. **Cartesian Join (Fan-Out) Risk**: Directly joining `order_items` to `order_payments` on `order_id` causes a row explosion (many-to-many join). For instance, an order with 3 items and 1 payment would duplicate that payment three times, inflating revenue 3×. Similarly, multiple payments and items can produce a Cartesian product, severely distorting sums. The solution is to pre-aggregate payments (and/or items) per order before joining to the order fact.

4. **Unstructured Text Fields**: Review text fields contain raw user input (e.g. `review_comment_message`) with possible newlines, trailing spaces, or backslashes. In practice, the ETL uses functions like `NULLIF(..., '')` and `TRIM(...)` to sanitize these fields. For example, one implementation strips whitespace from `review_comment_message` and handles empty strings explicitly, ensuring clean insertion into the data warehouse.

5. **Data Integrity Flag**: The `silver.orders` table now includes `is_date_missing_flag`, which acts as a data quality indicator for identifying incomplete delivery records.

6. **Normalization**: All textual categorical data (status, payment types, categories) has been cast to `LOWER` to ensure consistency in joins and filters.

7. **Spatial Consistency**: `silver.customers` and `silver.sellers` both now use `zip_code` (derived from `prefix`) and standardized city/state casing, facilitating cleaner joins with `silver.geolocation`.

8. **Predictive Feature & SLA Retention**: Crucial supply-chain checkpoints (`estimated_delivery_ts`, `shipping_limit_ts`, `approved_ts`, `carrier_delivered_ts`) and physical properties (`weight_g`, package dimensions) are deliberately kept and typed in the Silver layer. This guarantees the pipeline can reliably feed the downstream XGBoost predictive delay engine and track shipping performance milestones accurately in Power BI dashboards.

**Sources:** Schema details and definitions are drawn from the official Olist dataset documentation and community resources. The traps and design notes reflect best practices established in Olist data engineering projects.