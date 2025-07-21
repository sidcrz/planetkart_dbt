WITH source AS (
    SELECT * FROM {{ ref('stg_products') }}
),

final AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS product_key,
        product_id,
        product_name,
        category,
        sku,
        cost
    FROM source
)

SELECT * FROM final
