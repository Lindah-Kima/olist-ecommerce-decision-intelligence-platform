SELECT 
    order_id, 
    order_purchase_timestamp 
FROM silver.orders 
ORDER BY order_purchase_timestamp DESC 
LIMIT 10;