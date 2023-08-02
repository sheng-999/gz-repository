{{ config(schema='transaction') }}

WITH 

  sales AS (SELECT * FROM {{ ref('stg_sales') }} )

  ,product AS (SELECT * FROM {{ ref('stg_product') }} )

SELECT
  s.date_date
  ### Key ###
  ,s.orders_id
  ,s.products_id
  ###########
	-- qty --
	,s.qty
  -- revenue --
  ,s.turnover
  -- cost --
  ,p.purchase_price
	,ROUND(s.qty*p.purchase_price,2) AS purchase_cost
	-- margin --
	,ROUND(s.turnover-s.qty*p.purchase_price,2) AS margin
    , 
   ROUND( SAFE_DIVIDE( (s.turnover - s.qty*p.purchase_price) , s.turnover ) , 2)
 as margin_percent
    , 
   ROUND( SAFE_SUBTRACT( s.turnover, ROUND(s.qty*p.purchase_price,2) )) 
 as product_margin
FROM sales s
INNER JOIN product p ON s.products_id = p.products_id