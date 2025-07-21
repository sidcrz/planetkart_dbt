with source as (
    select * from {{ source('planetkart_raw', 'order_items') }}
),

renamed as (
    select
        order_id as ORDER_ID,
        product_id as PRODUCT_ID,
        quantity as QUANTITY,
        unit_price as UNIT_PRICE,
        quantity * unit_price as TOTAL_PRICE
    from source
)

select * from renamed
