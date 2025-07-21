with source as (
    select * from {{ source('planetkart_raw', 'regions') }}
),

renamed as (
    select
        region_id as REGION_ID,
        planet as PLANET,
        zone as ZONE
    from source
)

select * from renamed
