{{ config(schema='transaction') }}

WITH 

  sales AS (SELECT * FROM `gz_raw_data.raw_gz_sales`)

  ,product AS (SELECT * FROM `gz_raw_data.raw_gz_product`)

SELECT
  s.date_date
  ### Key ###
  ,s.orders_id
  --- descriptions: pk for orders ----
  ,s.pdt_id AS products_id
  --- descriptions: pk for product reference ---- 
  ###########
	-- qty --
	,s.quantity AS qty
  -- revenue --
  ,s.revenue AS turnover
  --- description: turnover with promos ---
  -- cost --
  ,CAST(p.purchSE_PRICE AS FLOAT64) AS purchase_price
	,ROUND(s.quantity*CAST(p.purchSE_PRICE AS FLOAT64),2) AS purchase_cost
    --- description: total purchase cost for each product id ------
	-- margin --
	,s.revenue - s.quantity*CAST(p.purchSE_PRICE AS FLOAT64) AS margin
    --- description: margin =total turnover - purchase costs 
FROM sales s
INNER JOIN product p ON s.pdt_id = p.products_id