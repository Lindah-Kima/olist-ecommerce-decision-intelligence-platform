CREATE SCHEMA IF NOT EXISTS gold;


-- Creates the master product dimension by combining product physical attributes with English category translations for simplified BI reporting and ML feature access.
CREATE TABLE gold.dim_products AS
SELECT 
    p.product_id,
    p.category AS category_pt,
    COALESCE(t.category_en, 'uncategorized') AS category_en,
    p.product_name_length,
    p.product_description_length,
    p.weight_g,
    p.length_cm,
    p.height_cm,
    p.width_cm
FROM silver.products p
LEFT JOIN silver.category_translation t 
    ON p.category = t.category_pt;


-- Creates the master customer dimension by isolating unique buyer identities and regional demographics for simplified BI filtering.
CREATE TABLE gold.dim_customers AS
SELECT 
    customer_id,
    customer_unique_id,
    zip_code,
    city,
    state
FROM silver.customers;

-- Creates the master seller dimension to centralize merchant profiles and warehouse locations for regional fulfillment analysis.
CREATE TABLE gold.dim_sellers AS
SELECT 
    seller_id,
    zip_code,
    city,
    state
FROM silver.sellers;

-- Creates a master calendar dimension to standardize date components, enabling seamless time-series analytics and seasonality tracking across all transactional checkpoints.
CREATE TABLE gold.dim_date AS
SELECT
    datum::DATE AS date_id,
    EXTRACT(YEAR FROM datum)::INT AS year,
    EXTRACT(MONTH FROM datum)::INT AS month,
    TRIM(TO_CHAR(datum, 'Month')) AS month_name,
    EXTRACT(DAY FROM datum)::INT AS day,
    EXTRACT(QUARTER FROM datum)::INT AS quarter,
    EXTRACT(ISODOW FROM datum)::INT AS day_of_week,
    CASE 
        WHEN EXTRACT(ISODOW FROM datum) IN (6, 7) THEN TRUE 
        ELSE FALSE 
    END AS is_weekend
FROM generate_series('2016-01-01'::DATE, '2018-12-31'::DATE, '1 day'::INTERVAL) AS datum;


DROP TABLE IF EXISTS gold.dim_date;

-- Creates a master calendar dimension with explicit text labels for weekends and weekdays to make downstream Power BI reporting intuitive for business stakeholders.
CREATE TABLE gold.dim_date AS
SELECT
    datum::DATE AS date_id,
    EXTRACT(YEAR FROM datum)::INT AS year,
    EXTRACT(MONTH FROM datum)::INT AS month,
    TRIM(TO_CHAR(datum, 'Month')) AS month_name,
    EXTRACT(DAY FROM datum)::INT AS day,
    EXTRACT(QUARTER FROM datum)::INT AS quarter,
    EXTRACT(ISODOW FROM datum)::INT AS day_of_week,
    CASE 
        WHEN EXTRACT(ISODOW FROM datum) IN (6, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS weekend_status
FROM generate_series('2016-01-01'::DATE, '2018-12-31'::DATE, '1 day'::INTERVAL) AS datum;

DROP TABLE IF EXISTS gold.dim_date;

CREATE TABLE gold.dim_date AS
SELECT
    datum::DATE AS date_id,
    EXTRACT(YEAR FROM datum)::INT AS year,
    EXTRACT(QUARTER FROM datum)::INT AS quarter,
    EXTRACT(MONTH FROM datum)::INT AS month,
    TRIM(TO_CHAR(datum, 'Month')) AS month_name,
    TO_CHAR(datum, 'Mon') AS month_short_name,
    TO_CHAR(datum, 'YYYY-MM') AS year_month,
    EXTRACT(DAY FROM datum)::INT AS day,
    EXTRACT(ISODOW FROM datum)::INT AS day_of_week,
    CASE
        WHEN EXTRACT(ISODOW FROM datum) IN (6, 7)
            THEN 'Weekend'
        ELSE 'Weekday'
    END AS weekend_status
FROM generate_series(
    '2016-01-01'::DATE,
    '2018-12-31'::DATE,
    '1 day'::INTERVAL
) AS datum;