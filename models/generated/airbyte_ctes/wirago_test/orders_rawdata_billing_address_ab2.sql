{{ config(
    sort = "_airbyte_emitted_at",
    schema = "_airbyte_wirago_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_rawdata_billing_address_ab1') }}
select
    _airbyte_rawdata_hashid,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(order_id as {{ dbt_utils.type_float() }}) as order_id,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast(post_code as {{ dbt_utils.type_string() }}) as post_code,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(address_line1 as {{ dbt_utils.type_string() }}) as address_line1,
    cast(address_line2 as {{ dbt_utils.type_string() }}) as address_line2,
    cast(billing_address_id as {{ dbt_utils.type_float() }}) as billing_address_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_rawdata_billing_address_ab1') }}
-- billing_address at orders/rawData/billing_address
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

