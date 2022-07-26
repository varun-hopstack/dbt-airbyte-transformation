{{ config(
    sort = "_airbyte_emitted_at",
    schema = "wirago_test",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_billingaddress_ab3') }}
select
    _airbyte_orders_hashid,
    zip,
    city,
    name,
    line1,
    line2,
    phone,
    state,
    country,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_billingaddress_hashid
from {{ ref('orders_billingaddress_ab3') }}
-- billingaddress at orders/billingAddress from {{ ref('orders_scd') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

