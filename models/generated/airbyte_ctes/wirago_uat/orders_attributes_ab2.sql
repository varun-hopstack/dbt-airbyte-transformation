{{ config(
    sort = "_airbyte_emitted_at",
    schema = "_airbyte_wirago_uat",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_attributes_ab1') }}
select
    _airbyte_orders_hashid,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(interface as {{ dbt_utils.type_string() }}) as interface,
    cast(weight_aibyte_transform as {{ dbt_utils.type_string() }}) as weight_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_attributes_ab1') }}
-- attributes at orders/attributes
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

