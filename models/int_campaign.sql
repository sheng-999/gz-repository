{{ config(
    materialized='table',
    partition_by={
      "field": "date_date",
      "data_type": "date",
      "granularity": "day"
    }
)}}


SELECT
date_date,		
paid_source,					
campaign_key,				
campaign_name,				
ads_cost,			
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