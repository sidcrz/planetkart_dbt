{{ config(materialized='view') }}

SELECT
    CUSTOMER_ID AS customer_id,
    FIRST_NAME AS first_name,
    LAST_NAME AS last_name,
    EMAIL AS email,
    REGION_ID AS region_id,
    SIGNUP_DATE AS signup_date
FROM {{ source('planetkart_raw', 'customers') }}
