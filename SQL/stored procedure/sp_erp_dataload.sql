CREATE or ALTER PROCEDURE sp_erp_dataload
as 
BEGIN


-----Truncate Tables
TRUNCATE TABLE silver.erp_px_cat_g1v2;
TRUNCATE table silver.erp_loc_a101;
TRUNCATE TABLE silver.erp_cust_az12;

-------------------------------------------------
INSERT into silver.erp_px_cat_g1v2
(
ID,
CAT,
SUBCAT,
MAINTENANCE
)
SELECT * FROM bronze.erp_PX_CAT_G1V2;


---------------------------------------------



INSERT INTO silver.erp_loc_a101
(
CID,
CNTRY
)
SELECT 
REPLACE(CID,'-','') AS CID,
CASE 
    WHEN CNTRY = 'US' THEN 'USA'
    WHEN CNTRY = 'DE' THEN 'Denmark'
    when CNTRY IS NULL OR TRIM(CNTRY) = '' THEN 'n/a'
else CNTRY
END AS COUN 
FROM bronze.erp_LOC_A101;


-------------------------------------------------------------------------



insert into silver.erp_cust_az12

SELECT
CASE
    when CID LIKE 'NAS%' THEN SUBSTRING(CID,4,LEN(CID))
    ELSE CID
END,
CASE
    WHEN TRY_CONVERT(DATE,BDATE) > GETDATE() THEN NULL
    ELSE TRY_CONVERT(DATE,BDATE)
END,
CASE
    WHEN UPPER(TRIM(GEN)) IN ('F','FEMALE') THEN 'Female'
    when upper(trim(GEN)) IN ('M','MALE') THEN 'Male'
    else 'n/a'
end 
from bronze.erp_CUST_AZ12



end
