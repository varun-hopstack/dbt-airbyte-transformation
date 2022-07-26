{{ config(
    sort = "_airbyte_emitted_at",
    schema = "_airbyte_wirago_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_shippingaddress_ab1') }}
select
    _airbyte_orders_hashid,
    cast(zip as {{ dbt_utils.type_string() }}) as zip,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(line1 as {{ dbt_utils.type_string() }}) as line1,
    cast(line2 as {{ dbt_utils.type_string() }}) as line2,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_shippingaddress_ab1') }}
-- shippingaddress at orders/shippingAddress
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

