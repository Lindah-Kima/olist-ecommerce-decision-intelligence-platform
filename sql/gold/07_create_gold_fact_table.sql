-- Creates the central fact table by combining item-level financial metrics with order lifecycle timestamps, establishing the core relationships to all dimension tables.
CREATE TABLE gold.fact_order_items AS
SELECT 
    i.order_id,
    i.order_item_id,
    o.customer_id,
    i.product_id,
    i.seller_id,
    -- Converts the purchase timestamp to a clean date key to link directly with gold.dim_date
    o.purchase_ts::DATE AS purchase_date_id,
    -- Keeps raw timestamps for the downstream XGBoost delivery prediction model
    o.purchase_ts,
    o.approved_ts,
    o.carrier_delivered_ts,
    o.delivered_ts,
    o.estimated_delivery_ts,
    i.shipping_limit_ts,
    -- Core numeric metrics for financial reporting
    i.price,
    i.freight_val
FROM silver.order_items i
INNER JOIN silver.orders o 
    ON i.order_id = o.order_id;