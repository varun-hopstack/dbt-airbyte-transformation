{{ config(
    sort = "_airbyte_emitted_at",
    schema = "_airbyte_wirago_uat",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_stageprogressions_ab1') }}
select
    _airbyte_orders_hashid,
    cast(cancelled as {{ dbt_utils.type_float() }}) as cancelled,
    cast(completed as {{ dbt_utils.type_float() }}) as completed,
    cast(packing_started as {{ dbt_utils.type_float() }}) as packing_started,
    cast(picking_started as {{ dbt_utils.type_float() }}) as picking_started,
    cast(sorting_started as {{ dbt_utils.type_float() }}) as sorting_started,
    cast(partial_completed as {{ dbt_utils.type_float() }}) as partial_completed,
    cast(picking_completed as {{ dbt_utils.type_float() }}) as picking_completed,
    cast(sorting_completed as {{ dbt_utils.type_float() }}) as sorting_completed,
    cast(awaiting_consignment as {{ dbt_utils.type_float() }}) as awaiting_consignment,
    cast(exception_aibyte_transform as {{ dbt_utils.type_string() }}) as exception_aibyte_transform,
    cast(unprocessed_aibyte_transform as {{ dbt_utils.type_string() }}) as unprocessed_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_stageprogressions_ab1') }}
-- stageprogressions at orders/stageProgressions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

