{{ config(
    sort = "_airbyte_emitted_at",
    schema = "wirago_test",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_rawdata_shipping_address_ab3') }}
select
    _airbyte_rawdata_hashid,
    city,
    email,
    phone,
    state,
    country,
    order_id,
    post_code,
    address_line1,
    address_line2,
    receiver_name,
    shipping_address_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_shipping_address_hashid
from {{ ref('orders_rawdata_shipping_address_ab3') }}
-- shipping_address at orders/rawData/shipping_address from {{ ref('orders_rawdata') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

