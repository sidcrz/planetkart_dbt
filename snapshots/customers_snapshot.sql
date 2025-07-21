{% snapshot customers_snapshot %}
{{
  config(
    target_schema='_Planetkart_analytics',
    unique_key='customer_id',
    strategy='check',
    check_cols=['first_name', 'last_name', 'email', 'region_id']
  )
}}

SELECT
  customer_id,
  first_name,
  last_name,
  email,
  signup_date,
  region_id
FROM {{ ref('stg_customers') }}

{% endsnapshot %}
