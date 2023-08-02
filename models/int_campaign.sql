{{ config(
    materialized='table',
    partition_by={
      "field": "date_date"
    }
)}}



SELECT
date_date,		
paid_source,					
campaign_key,				
campaign_name,				
ads_cost,	
sum(ads_cost) over(partition by date_date, campaign_key) as campaign_cost,			
impression,				
click
FROM 
(SELECT * from {{ ref('stg_adwords') }}
UNION ALL 
SELECT * from {{ ref('stg_bing') }}
UNION ALL 
SELECT * FROM {{ ref('stg_criteo') }}
UNION ALL 
SELECT * FROM {{ ref('stg_facebook') }})
ORDER BY date_date