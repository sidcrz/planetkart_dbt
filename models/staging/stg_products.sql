{{ config(materialized='view') }}

SELECT
  product_id,
  product_name,
  category,
  sku,
  cost
FROM {{ source('planetkart_raw', 'products') }}
