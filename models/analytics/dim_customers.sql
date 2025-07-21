WITH source AS (
  SELECT * FROM {{ ref('stg_customers') }}
),

final AS (
  SELECT
    {{ dbt_utils.generate_surrogate_key(['customer_id']) }} AS customer_key,
    customer_id,
    first_name || ' ' || last_name AS customer_name,
    email,
    signup_date,
    region_id
  FROM source
)

SELECT * FROM final
