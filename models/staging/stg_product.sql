SELECT 
products_id,
cast(purchSE_PRICE as FLOAT64) as purchase_price 
from gz_raw_data.raw_gz_product
where cast(purchSE_PRICE as FLOAT64) > 0