/*
===============================================================================
DDL SCRIPT: CREATE GOLD VIEWS
===============================================================================
SCRIPT PURPOSE:
    This script creates dimension and fact views for the Gold layer
    of the data warehouse. The Gold layer represents the final
    analytics-ready star schema.

    The views combine and enrich data from the Silver layer,
    applying surrogate keys and business-friendly attributes.

USAGE:
    - These views are intended for reporting, dashboards,
      and analytical queries.
===============================================================================
*/

-- =============================================================================
-- CREATE DIMENSION: gold.dim_products
-- =============================================================================
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY prd_start_dt, prd_key) AS product_key, -- Surrogate key
    cp.prd_id       AS product_id,
    cp.prd_key      AS product_number,
    cp.prd_nm       AS product_name,
    cp.cat_id       AS category_id,
    ep.cat          AS product_category,
    ep.subcat       AS product_subcategory,
    ep.maintenance,
    cp.prd_cost     AS product_cost,
    cp.prd_line     AS product_line,
    cp.prd_start_dt AS product_startdate
FROM silver.crm_prd_info cp
LEFT JOIN silver.erp_px_cat_g1v2 ep
    ON cp.cat_id = ep.id
WHERE prd_end_dt IS NULL; -- Keep only active products
GO

-- =============================================================================
-- CREATE DIMENSION: gold.dim_customers
-- =============================================================================
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO

CREATE VIEW gold.dim_customers AS
SELECT
    ROW_NUMBER() OVER (ORDER BY cst_key) AS customer_key, -- Surrogate key
    ci.cst_id            AS customer_id,
    ci.cst_key           AS customer_number,
    ci.cst_firstname     AS firstname,
    ci.cst_lastname      AS lastname,
    cl.cntry             AS country,
    ci.cst_marital_status AS marital_status,
    CASE	
        WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr -- CRM is primary source
        ELSE COALESCE(ec.gen, 'n/a')               -- Fallback to ERP data
    END                  AS gender,
    ec.bdate             AS birth_date,
    ci.cst_create_date   AS create_date
FROM silver.crm_cust_info ci 
LEFT JOIN silver.erp_cust_az12 ec
    ON ci.cst_key = ec.cid
LEFT JOIN silver.erp_loc_a101 cl
    ON ci.cst_key = cl.cid;
GO

-- =============================================================================
-- CREATE FACT TABLE: gold.fact_sales
-- =============================================================================
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO

CREATE VIEW gold.fact_sales AS
SELECT 
    ss.sls_ord_num as order_number,
    gp.product_key,
    gc.customer_key,
    ss.sls_order_dt as order_date,
    ss.sls_ship_dt as shipment_date,
    ss.sls_due_dt as due_date,
    ss.sls_sales as sales,
    ss.sls_quantity as quantity,
    ss.sls_price as price
FROM silver.crm_sales_details ss
LEFT JOIN gold.dim_customers gc
    ON ss.sls_cust_id = gc.customer_id
LEFT JOIN gold.dim_products gp
    ON ss.sls_prd_key = gp.product_number;
GO
