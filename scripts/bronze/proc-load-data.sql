
-- Stored Procedure: Loads all CRM and ERP source files into the Bronze layer.
-- WARNING:
-- 1. SQL Server service account must have read access to the CSV file locations.
-- 2. BULK INSERT reads files from the SQL Server machine, not your local SSMS machine.
-- 3. Running this procedure will TRUNCATE existing data in all Bronze tables.

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN

    BEGIN TRY

        PRINT '===================================================';
        PRINT 'LOADING BRONZE LAYER';
        PRINT '===================================================';

        PRINT '---------------------------------------------------';
        PRINT 'LOADING CRM TABLES';
        PRINT '---------------------------------------------------';

        PRINT '>> Truncating Table: bronze.crm_cust_info';

        -- Remove old data before performing a full reload.
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>> Inserting Data Into: bronze.crm_cust_info';

        BULK INSERT bronze.crm_cust_info
        FROM 'D:\DATA WITH BARAA PROJECTS\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,      -- Skip the header row.
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        PRINT '>> Truncating Table: bronze.crm_prd_info';

        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>> Inserting Data Into: bronze.crm_prd_info';

        BULK INSERT bronze.crm_prd_info
        FROM 'D:\DATA WITH BARAA PROJECTS\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        PRINT '>> Truncating Table: bronze.crm_sales_details';

        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>> Inserting Data Into: bronze.crm_sales_details';

        BULK INSERT bronze.crm_sales_details
        FROM 'D:\DATA WITH BARAA PROJECTS\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        PRINT '---------------------------------------------------';
        PRINT 'LOADING ERP TABLES';
        PRINT '---------------------------------------------------';

        PRINT '>> Truncating Table: bronze.erp_loc_a101';

        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT '>> Inserting Data Into: bronze.erp_loc_a101';

        BULK INSERT bronze.erp_loc_a101
        FROM 'D:\DATA WITH BARAA PROJECTS\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        PRINT '>> Truncating Table: bronze.erp_cust_az12';

        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT '>> Inserting Data Into: bronze.erp_cust_az12';

        BULK INSERT bronze.erp_cust_az12
        FROM 'D:\DATA WITH BARAA PROJECTS\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';

        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';

        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'D:\DATA WITH BARAA PROJECTS\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

    END TRY

    -- Centralized error handling for the entire ETL process.
    BEGIN CATCH
        PRINT '====================================================';
        PRINT 'AN ERROR OCCURED DURING LOADING';
        PRINT 'ERROR MESSAGE: ' + ERROR_MESSAGE();
        PRINT 'ERROR NUMBER : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT '====================================================';
    END CATCH
END;
