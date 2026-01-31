/*
===============================================================================
STORED PROCEDURE: LOAD BRONZE LAYER (SOURCE -> BRONZE)
===============================================================================
SCRIPT PURPOSE:
    This stored procedure loads raw data from external CSV files
    into the BRONZE schema tables.

    Actions performed:
    - Truncates existing bronze tables
    - Loads fresh data using BULK INSERT
    - Logs execution time for each table
    - Logs total batch duration

PARAMETERS:
    None

USAGE:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    DECLARE 
        @start_time DATETIME,
        @end_time DATETIME,
        @batch_start_time DATETIME,
        @batch_end_time DATETIME;

    BEGIN TRY

        SET @batch_start_time = GETDATE();

        PRINT '================================================'
        PRINT 'LOADING BRONZE LAYER'
        PRINT '================================================'

        /* =================================================
           LOAD CRM TABLES
           ================================================= */
        PRINT '------------------------------------------------'
        PRINT 'LOADING CRM TABLES'
        PRINT '------------------------------------------------'

        /* CRM CUSTOMER TABLE */
        SET @start_time = GETDATE();
        PRINT '>> TRUNCATING TABLE : bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>> INSERTING DATA   : bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM 'D:\SQL-DATA-WAREHOUSE-PROJECT\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION    : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> ------------------------------------------------';

        /* CRM PRODUCT TABLE */
        SET @start_time = GETDATE();
        PRINT '>> TRUNCATING TABLE : bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>> INSERTING DATA   : bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'D:\SQL-DATA-WAREHOUSE-PROJECT\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION    : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> ------------------------------------------------';

        /* CRM SALES DETAILS TABLE */
        SET @start_time = GETDATE();
        PRINT '>> TRUNCATING TABLE : bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>> INSERTING DATA   : bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'D:\SQL-DATA-WAREHOUSE-PROJECT\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION    : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> ------------------------------------------------';

        /* =================================================
           LOAD ERP TABLES
           ================================================= */
        PRINT '------------------------------------------------'
        PRINT 'LOADING ERP TABLES'
        PRINT '------------------------------------------------'

        /* ERP LOCATION TABLE */
        SET @start_time = GETDATE();
        PRINT '>> TRUNCATING TABLE : bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT '>> INSERTING DATA   : bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM 'D:\SQL-DATA-WAREHOUSE-PROJECT\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION    : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> ------------------------------------------------';

        /* ERP CUSTOMER TABLE */
        SET @start_time = GETDATE();
        PRINT '>> TRUNCATING TABLE : bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT '>> INSERTING DATA   : bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM 'D:\SQL-DATA-WAREHOUSE-PROJECT\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION    : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> ------------------------------------------------';

        /* ERP PRODUCT CATEGORY TABLE */
        SET @start_time = GETDATE();
        PRINT '>> TRUNCATING TABLE : bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT '>> INSERTING DATA   : bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'D:\SQL-DATA-WAREHOUSE-PROJECT\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION    : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> ------------------------------------------------';

        /* =================================================
           BATCH COMPLETION
           ================================================= */
        SET @batch_end_time = GETDATE();

        PRINT '================================================'
        PRINT 'BRONZE LAYER LOAD COMPLETED SUCCESSFULLY'
        PRINT 'TOTAL LOAD DURATION : ' 
              + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) 
              + ' seconds';
        PRINT '================================================'

    END TRY
    BEGIN CATCH

        PRINT '================================================'
        PRINT 'ERROR OCCURRED DURING BRONZE LAYER LOAD'
        PRINT 'ERROR MESSAGE : ' + ERROR_MESSAGE();
        PRINT 'ERROR NUMBER  : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'ERROR STATE   : ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '================================================'

    END CATCH
END;
