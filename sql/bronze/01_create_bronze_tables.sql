-- Create an isolated schema for the raw ingestion
CREATE SCHEMA bronze;

-- 1. Create the raw Customers table
CREATE TABLE bronze.customers (
    customer_id VARCHAR(255),
    customer_unique_id VARCHAR(255),
    customer_zip_code_prefix VARCHAR(255),
    customer_city VARCHAR(255),
    customer_state VARCHAR(255)
);

-- 2. Create the raw Orders table
CREATE TABLE bronze.orders (
    order_id VARCHAR(255),
    customer_id VARCHAR(255),
    order_status VARCHAR(255),
    order_purchase_timestamp VARCHAR(255),
    order_approved_at VARCHAR(255),
    order_delivered_carrier_date VARCHAR(255),
    order_delivered_customer_date VARCHAR(255),
    order_estimated_delivery_date VARCHAR(255)
);

-- 3. Create the raw Products table
CREATE TABLE bronze.products (
    product_id VARCHAR(255),
    product_category_name VARCHAR(255),
    product_name_length VARCHAR(255),
    product_description_length VARCHAR(255),
    product_photos_qty VARCHAR(255),
    product_weight_g VARCHAR(255),
    product_length_cm VARCHAR(255),
    product_height_cm VARCHAR(255),
    product_width_cm VARCHAR(255)
);

-- 4. Order Items (The details of what was sold)
CREATE TABLE bronze.order_items (
    order_id VARCHAR,
    order_item_id VARCHAR,
    product_id VARCHAR,
    seller_id VARCHAR,
    shipping_limit_date VARCHAR,
    price VARCHAR,
    freight_value VARCHAR
);

-- 5. Order Payments (How the customer paid)
CREATE TABLE bronze.order_payments (
    order_id VARCHAR,
    payment_sequential VARCHAR,
    payment_type VARCHAR,
    payment_installments VARCHAR,
    payment_value VARCHAR
);

-- 6. Order Reviews (Customer feedback)
CREATE TABLE bronze.order_reviews (
    review_id VARCHAR(500),
    order_id VARCHAR(500),
    review_score VARCHAR(100),
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date VARCHAR(500),
    review_answer_timestamp VARCHAR(500)
);

-- 7. Sellers (Who sold the product)
CREATE TABLE bronze.sellers (
    seller_id VARCHAR,
    seller_zip_code_prefix VARCHAR,
    seller_city VARCHAR,
    seller_state VARCHAR
);

-- 8. Geolocation (Mapping zip codes to coordinates)
CREATE TABLE bronze.geolocation (
    geolocation_zip_code_prefix VARCHAR,
    geolocation_lat VARCHAR,
    geolocation_lng VARCHAR,
    geolocation_city VARCHAR,
    geolocation_state VARCHAR
);

-- 9. Language mapping for product categories
CREATE TABLE bronze.product_category_name_translation (
    product_category_name VARCHAR,
    product_category_name_english VARCHAR
);

