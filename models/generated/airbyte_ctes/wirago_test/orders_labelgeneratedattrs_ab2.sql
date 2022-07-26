{{ config(
    sort = "_airbyte_emitted_at",
    schema = "_airbyte_wirago_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_labelgeneratedattrs_ab1') }}
select
    _airbyte_orders_hashid,
    cast(machine as {{ dbt_utils.type_string() }}) as machine,
    cast({{ adapter.quote('timestamp') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('timestamp') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_labelgeneratedattrs_ab1') }}
-- labelgeneratedattrs at orders/labelGeneratedAttrs
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

