
CREATE or ALTER VIEW gold.dim_product_vw
as
SELECT 
cp.prd_id as product_id,
cp.prd_key as product_number,
cp.prd_nm as product_name,
cp.prd_line as product_line,
cp.cat_id as category_id,
ep.CAT AS category_name,
ep.SUBCAT AS subcategory,
ep.MAINTENANCE AS maintenance,
cp.prd_cost as product_cost,
cp.prd_start_dt as start_date,
cp.prd_end_dt as end_date
from silver.crm_prd_info AS cp 
LEFT join silver.erp_px_cat_g1v2 as ep
on cp.cat_id = ep.ID


-------------------------------------------------------------------



CREATE OR ALTER VIEW gold.dim_customer_vw
AS
select
ci.cst_id as customer_id,
ci.cst_key as customer_number,
ci.cst_firstname as first_name,
ci.cst_lastname as last_name,
ci.cst_marital_status as marital_status,
CASE
    WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
    ELSE COALESCE(ca.GEN, 'n/a')
END as gender,
--ci.cst_gndr as gender,
ci.cst_create_date as create_date,
cl.CNTRY as country,
--ca.GEN as gen,
ca.BDATE as birth_date
from silver.crm_cust_info as ci
left join silver.erp_cust_az12 as ca
on ci.cst_key = ca.CID
left join silver.erp_loc_a101 as cl
on ci.cst_key = cl.CID


---------------------------------------------------------------------------------


CREATE or alter view gold.fact_sales_vw
as
select
sls_ord_num as order_num,
sls_prd_key as product_key,
sls_cust_id as customer_key,
sls_order_dt as order_date,
year(try_convert(date,sls_order_dt,103)) YR,
sls_ship_dt as ship_date,
sls_due_dt as due_date,
sls_sales as sales_amount,
sls_quantity as sls_quantity,
sls_price as price
from silver.crm_sales_details
