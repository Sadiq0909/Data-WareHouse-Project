CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN

DECLARE @start_time DATETIME , @end_time DATETIME , @a DATETIME  , @b DATETIME

BEGIN TRY
	SET @a = GETDATE() ;
	PRINT '------------------' ; 
	PRINT 'LOADING BRONZE LAYER'
	PRINT '------------------'

	SET @start_time = GETDATE() 
	PRINT '------------------' ; 
	PRINT 'LOADING CRM TABLES'
	PRINT '------------------'
	Truncate TABLE bronze.crm_cust_info ;
	BULK INSERT bronze.crm_cust_info
	FROM 'C:\Users\Asus\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	WITH (
		FIRSTROW = 2 ,
		FIELDTERMINATOR = ',' ,
		TABLOCK 
	)



	Truncate TABLE bronze.crm_prd_info ;
	BULK INSERT bronze.crm_prd_info
	FROM 'C:\Users\Asus\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	WITH (
		FIRSTROW = 2 ,
		FIELDTERMINATOR = ',' ,
		TABLOCK 
	)



	Truncate TABLE bronze.crm_sales_details;
	BULK INSERT bronze.crm_sales_details
	FROM 'C:\Users\Asus\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	WITH (
		FIRSTROW = 2 ,
		FIELDTERMINATOR = ',' ,
		TABLOCK 
	)
	SET @end_time = GETDATE() 
	PRINT 'LOAD DURATION : ' + CAST(DATEDIFF(second , @start_time , @end_time) AS NVARCHAR ) + 'SECONDS'

	PRINT '------------------' ; 
	PRINT 'LOADING ERP TABLES'
	PRINT '------------------'

	SET @start_time = GETDATE()
 

	Truncate TABLE bronze.erp_cust_az12 ;
	BULK INSERT bronze.erp_cust_az12
	FROM 'C:\Users\Asus\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
	WITH (
		FIRSTROW = 2 ,
		FIELDTERMINATOR = ',' ,
		TABLOCK 
	)



	Truncate TABLE bronze.erp_loc_a101 ;
	BULK INSERT bronze.erp_loc_a101
	FROM 'C:\Users\Asus\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
	WITH (
		FIRSTROW = 2 ,
		FIELDTERMINATOR = ',' ,
		TABLOCK 
	)



	Truncate TABLE bronze.erp_px_cat_g1v2 ;
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM 'C:\Users\Asus\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
	WITH (
		FIRSTROW = 2 ,
		FIELDTERMINATOR = ',' ,
		TABLOCK 
	)
	SET @end_time = GETDATE() 
	PRINT 'LOAD DURATION : ' + CAST(DATEDIFF(second , @start_time , @end_time) AS NVARCHAR ) + 'SECONDS'

	PRINT '   '
	SET @b = GETDATE() ;


	PRINT '------------------' ; 
	PRINT ' EVERYTHING LOADED'
	PRINT 'LOAD DURATION OF BRONZE LAYER : ' + CAST(DATEDIFF(second , @a , @b) AS NVARCHAR ) + 'SECONDS'
	PRINT '------------------'

END TRY

BEGIN CATCH
	PRINT '--------------------------'
	PRINT 'ERROR OCCURED WHILE LOADING BRONZE LAYER '
	PRINT '------------------------'
END CATCH 

END ;

EXEC bronze.load_bronze
