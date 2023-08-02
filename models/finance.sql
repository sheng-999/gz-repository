{{
  config(
    materialized='table'
  )
}}

----------- reference --------------------

WITH orders AS (
    SELECT * FROM {{ ref('orders') }}
),
campaign AS (
    SELECT * FROM {{ ref('int_campaign') }}
),
------------ aggregation ----------------
date_orders AS (
    SELECT
    date_date,
    SUM(turnover) as turnover,
    SUM(product_margin) AS product_margin,
    SUM(shipping_fee) AS shipping_fee,
    SUM(cast(ship_cost as float64)) AS ship_cost,
    SUM(logCost) AS log_cost,
    SUM(operational_margin) AS operational_margin
    FROM orders
    GROUP BY date_date
    ),

date_campaign AS (
SELECT 
    date_date,
    SUM(ads_cost) as ads_cost,
    SUM(impression) as impression,
    SUM(click) as click
    FROM campaign
    GROUP BY date_date
),

------------ join -------------------
date_join AS (
    SELECT
        date_date,
------------ orders metrics -------------
        turnover,
        product_margin,
        shipping_fee,
        ship_cost,
        log_cost,
        operational_margin,
------------ ads metrics ---------------
        ads_cost,
        impression,
        click,
    FROM date_orders
    LEFT JOIN date_campaign USING (date_date)
    ),

------------ Enrichment  ----------------
    ads_margin AS (
        SELECT
            *
            ,operational_margin - ads_cost AS ads_margin
        FROM date_join
    )
SELECT * FROM ads_margin
