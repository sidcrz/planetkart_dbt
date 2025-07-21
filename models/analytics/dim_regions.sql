WITH source AS (
  SELECT * FROM {{ ref('stg_regions') }}
),

final AS (
  SELECT
    {{ dbt_utils.generate_surrogate_key(['region_id']) }} AS region_key,
    region_id,
    planet,
    zone
  FROM source
)

SELECT * FROM final
