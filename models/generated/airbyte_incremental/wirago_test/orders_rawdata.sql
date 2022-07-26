{{ config(
    sort = "_airbyte_emitted_at",
    schema = "wirago_test",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_rawdata_ab3') }}
select
    _airbyte_orders_hashid,
    invoice,
    order_id,
    awb_image,
    interface,
    order_date,
    total_item,
    order_email,
    order_status,
    payment_date,
    product_type,
    shipping_type,
    order_products,
    payment_status,
    billing_address,
    shipping_address,
    total_weight_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_rawdata_hashid
from {{ ref('orders_rawdata_ab3') }}
-- rawdata at orders/rawData from {{ ref('orders_scd') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

