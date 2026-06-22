CREATE SCHEMA IF NOT EXISTS silver;

-- 1. Transform Orders (Fixing Temporal Data)
CREATE TABLE silver.orders AS
SELECT 
    order_id,
    customer_id,
    order_status,
    NULLIF(order_purchase_timestamp, '')::TIMESTAMP AS order_purchase_timestamp,
    NULLIF(order_approved_at, '')::TIMESTAMP AS order_approved_at,
    NULLIF(order_delivered_carrier_date, '')::TIMESTAMP AS order_delivered_carrier_date,
    NULLIF(order_delivered_customer_date, '')::TIMESTAMP AS order_delivered_customer_date,
    NULLIF(order_estimated_delivery_date, '')::TIMESTAMP AS order_estimated_delivery_date
FROM bronze.orders;

-- 2. Transform Order Items (Fixing Numeric Pricing)
CREATE TABLE silver.order_items AS
SELECT 
    order_id,
    NULLIF(order_item_id, '')::INTEGER AS order_item_id,
    product_id,
    seller_id,
    NULLIF(shipping_limit_date, '')::TIMESTAMP AS shipping_limit_date,
    NULLIF(price, '')::NUMERIC AS price,
    NULLIF(freight_value, '')::NUMERIC AS freight_value
FROM bronze.order_items;

-- 3. Transform Order Payments (Fixing Financials)
CREATE TABLE silver.order_payments AS
SELECT 
    order_id,
    NULLIF(payment_sequential, '')::INTEGER AS payment_sequential,
    payment_type,
    NULLIF(payment_installments, '')::INTEGER AS payment_installments,
    NULLIF(payment_value, '')::NUMERIC AS payment_value
FROM bronze.order_payments;