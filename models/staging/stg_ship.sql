SELECT 
orders_id,	
shipping_fee,			
logCost AS log_cost,
cast(ship_cost as float64) as ship_cost
from gz_raw_data.raw_gz_ship