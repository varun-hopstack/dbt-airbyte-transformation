{{ config(
    sort = "_airbyte_emitted_at",
    schema = "wirago_test",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_attributes_ab3') }}
select
    _airbyte_orders_hashid,
    email,
    interface,
    weight_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_attributes_hashid
from {{ ref('orders_attributes_ab3') }}
-- attributes at orders/attributes from {{ ref('orders_scd') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

