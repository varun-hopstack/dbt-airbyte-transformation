{{ config(
    sort = "_airbyte_emitted_at",
    schema = "_airbyte_wirago_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders_scd') }}
select
    _airbyte_orders_hashid,
    {{ json_extract_scalar('attributes', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('attributes', ['interface'], ['interface']) }} as interface,
    {{ json_extract_scalar('attributes', ['weight_aibyte_transform'], ['weight_aibyte_transform']) }} as weight_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_scd') }} as table_alias
-- attributes at orders/attributes
where 1 = 1
and attributes is not null
{{ incremental_clause('_airbyte_emitted_at') }}

