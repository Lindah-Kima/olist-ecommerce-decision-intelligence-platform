-- Check our total customer count (Should return exactly 99,441 rows)
SELECT COUNT(*) FROM bronze.customers;

-- Inspect a few records to verify that Brazilian characters loaded correctly
-- Look closely at the "customer_city" column to ensure there are no corrupt, broken characters
SELECT * FROM bronze.customers LIMIT 10;

-- Check for structural anomalies: Are there missing values (NULLs) in our core timestamps?
SELECT 
    COUNT(*) AS total_orders,
    COUNT(order_delivered_customer_date) AS delivered_orders_with_dates,
    (COUNT(*) - COUNT(order_delivered_customer_date)) AS missing_delivery_dates
FROM bronze.orders;

SELECT COUNT(*) FROM bronze.products;

SELECT COUNT(*) FROM bronze.order_items;

SELECT COUNT(*) FROM bronze.geolocation;

SELECT COUNT(*) FROM bronze.order_payments;

SELECT COUNT(*) FROM bronze.order_reviews;

SELECT COUNT(*) FROM bronze.orders;

SELECT COUNT(*) FROM bronze.product_category_name_translation;

SELECT COUNT(*) FROM bronze.sellers;




