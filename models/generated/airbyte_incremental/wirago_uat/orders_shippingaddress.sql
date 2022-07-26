{{ config(
    sort = "_airbyte_emitted_at",
    schema = "wirago_uat",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_shippingaddress_ab3') }}
select
    _airbyte_orders_hashid,
    zip,
    city,
    name,
    email,
    line1,
    line2,
    phone,
    state,
    country,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_shippingaddress_hashid
from {{ ref('orders_shippingaddress_ab3') }}
-- shippingaddress at orders/shippingAddress from {{ ref('orders') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

