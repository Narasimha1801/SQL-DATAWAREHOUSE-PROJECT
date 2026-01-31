/*
===============================================================================
BRONZE LAYER TABLE CREATION (SOURCE -> BRONZE)
===============================================================================
SCRIPT PURPOSE:
    This script creates raw ingestion tables in the BRONZE schema.
    These tables store data exactly as received from source systems
    (CRM and ERP) with minimal transformation.

    Actions performed:
    - Creates CRM and ERP bronze tables
    - Tables are designed for BULK INSERT operations
    - Data cleansing and type standardization will occur in SILVER layer

PARAMETERS:
    None

USAGE:
    Run once during environment setup or schema initialization.
===============================================================================
*/

CREATE TABLE bronze.crm_cust_info (
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE
);

CREATE TABLE bronze.crm_prd_info (
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_date DATE,
    prd_end_date DATE
);

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);

CREATE TABLE bronze.erp_cust_az12 (
    cid NVARCHAR(50),
    bdate DATE,
    gen NVARCHAR(50)
);

CREATE TABLE bronze.erp_loc_a101 (
    cid NVARCHAR(50),
    cntry NVARCHAR(50)
);

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id NVARCHAR(50),
    cat NVARCHAR(50),
    subcat NVARCHAR(50),
    maintenance NVARCHAR(50)
);
