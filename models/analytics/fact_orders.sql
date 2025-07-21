WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),

order_items AS (
    SELECT * FROM {{ ref('stg_order_items') }}
),

customers AS (
    SELECT * FROM {{ ref('dim_customers') }}
),

products AS (
    SELECT * FROM {{ ref('dim_products') }}
),

regions AS (
    SELECT * FROM {{ ref('dim_regions') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['oi.order_id', 'oi.product_id']) }} AS order_key,

    -- Natural Keys
    oi.order_id,
    o.customer_id,
    oi.product_id,

    -- Surrogate (Dimension) Keys
    c.customer_key,
    p.product_key,
    r.region_key,

    -- Attributes
    o.order_date,
    o.status,
    oi.quantity,
    oi.unit_price,
    oi.total_price,

    -- Derived fields
    CASE WHEN oi.quantity = 1 THEN TRUE ELSE FALSE END AS is_single_item,
    CASE WHEN LOWER(o.status) = 'completed' THEN TRUE ELSE FALSE END AS is_completed,

    -- Audit column
    CURRENT_TIMESTAMP AS data_loaded_at

FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON oi.product_id = p.product_id
JOIN regions r ON c.region_id = r.region_id

WHERE oi.quantity > 0
  AND oi.unit_price > 0
