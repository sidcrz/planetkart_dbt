with source as (

    select * 
    from {{ source('planetkart_raw', 'orders') }}

),

renamed as (

    select
        order_id,
        customer_id,
        order_date,
        status

    from source

)

select * from renamed
