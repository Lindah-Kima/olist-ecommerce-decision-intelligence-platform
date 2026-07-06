DROP TABLE IF EXISTS gold.fact_order_items;

-- Creates the central fact table by combining item-level financial metrics with order lifecycle timestamps,
-- establishing the core relationships to all dimension tables.
CREATE TABLE gold.fact_order_items AS
SELECT
    i.order_id,
    i.order_item_id,

    -- Customer identifiers
    o.customer_id,
    c.customer_unique_id,

    i.product_id,
    i.seller_id,

    -- Converts the purchase timestamp to a clean date key
    o.purchase_ts::DATE AS purchase_date_id,

    -- Lifecycle timestamps
    o.purchase_ts,
    o.approved_ts,
    o.carrier_delivered_ts,
    o.delivered_ts,
    o.estimated_delivery_ts,
    i.shipping_limit_ts,

    -- Financial metrics
    i.price,
    i.freight_val

FROM silver.order_items i

INNER JOIN silver.orders o
    ON i.order_id = o.order_id

INNER JOIN silver.customers c
    ON o.customer_id = c.customer_id;