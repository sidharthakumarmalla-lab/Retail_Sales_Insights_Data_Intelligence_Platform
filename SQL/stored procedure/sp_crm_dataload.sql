CREATE or ALTER PROCEDURE sp_crm_dataload
as 
BEGIN


-----Truncate Tables
TRUNCATE TABLE silver.crm_cust_info;
TRUNCATE table silver.crm_prd_info;
TRUNCATE TABLE silver.crm_sales_details;



---------------------------------------------------------------------



INSERT INTO silver.crm_cust_info

SELECT
cst_id,
cst_key,
trim(cst_firstname),
trim(cst_lastname),
CASE
    WHEN upper(trim(cst_marital_status)) = 'M' then 'Married'
    WHEN upper(trim(cst_marital_status)) = 'S' then 'Single'
    when cst_marital_status is null or cst_marital_status = '' then 'n/a'
END,
CASE
    when cst_gndr = 'M' then 'Male'
    WHEN cst_gndr = 'F' then 'Female'
    when cst_gndr is null or cst_gndr = '' then 'n/a'
end,
cast(cst_create_date as date)
from bronze.crm_cust_info;


-------------------------------------------------------------------------------------------------------





INSERT INTO silver.crm_prd_info

SELECT
prd_id,
REPLACE(SUBSTRING(prd_key,1,5),'-','_') as cat_id,
SUBSTRING(prd_key,7,len(prd_key)) as prd_key,
prd_nm,
cast(ISNULL(prd_cost,0)as int) as prd_cost,
CASE
    when UPPER(trim(prd_line)) = 'R' THEN 'Road'
    when UPPER(trim(prd_line)) = 'S' THEN 'Other Sales'
    when UPPER(trim(prd_line)) = 'M' THEN 'Mountain'
    when UPPER(trim(prd_line)) = 'T' THEN 'Touring'
    else 'n/a'
end as prd_line,
cast(prd_start_dt as date) as prd_start_dt,
DATEADD(day,1,cast(prd_start_dt as date)) as prd_end_dt
from bronze.crm_prd_info;



-----------------------------------------------------------------------------------





INSERT INTO silver.crm_sales_details

SELECT
sls_ord_num,
sls_prd_key,
cast(sls_cust_id as int),
----orderdate
CASE
    WHEN sls_order_dt = 0 or len(sls_order_dt) != 8 then NULL
    ELSE CONVERT(DATE,sls_order_dt,103)
end as sls_order_dt,
----shipdate
CASE
    WHEN sls_ship_dt = 0 or len(sls_ship_dt) != 8 then NULL
    ELSE CONVERT(DATE,sls_ship_dt,103)
end as sls_ship_dt,
------duedt
CASE
    WHEN sls_due_dt = 0 or len(sls_due_dt) != 8 then NULL
    ELSE CONVERT(DATE,sls_due_dt,103)
end as sls_due_dt,
----sales
case
    when cast(sls_sales as int) is null or cast(sls_sales as int) <= 0
    then cast(sls_quantity as int) * cast(sls_price as int)
    else cast(sls_sales as int)
end as sls_sales,
----quantity
cast(sls_quantity as int),
----price
CASE
    WHEN cast(sls_price as int) is null or cast(sls_price as int) <= 0 
    then cast(sls_sales as int) / cast(sls_quantity as int)
    else cast(sls_price as int)
end as sls_price
from bronze.crm_sales_details


end
