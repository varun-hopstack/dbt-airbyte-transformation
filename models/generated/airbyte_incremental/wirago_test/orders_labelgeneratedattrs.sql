{{ config(
    sort = "_airbyte_emitted_at",
    schema = "wirago_test",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_labelgeneratedattrs_ab3') }}
select
    _airbyte_orders_hashid,
    machine,
    {{ adapter.quote('timestamp') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_labelgeneratedattrs_hashid
from {{ ref('orders_labelgeneratedattrs_ab3') }}
-- labelgeneratedattrs at orders/labelGeneratedAttrs from {{ ref('orders_scd') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

