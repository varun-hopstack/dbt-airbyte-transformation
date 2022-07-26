{{ config(
    sort = "_airbyte_emitted_at",
    schema = "_airbyte_wirago_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders_scd') }}
select
    _airbyte_orders_hashid,
    {{ json_extract_scalar('billingaddress', ['zip'], ['zip']) }} as zip,
    {{ json_extract_scalar('billingaddress', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('billingaddress', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('billingaddress', ['line1'], ['line1']) }} as line1,
    {{ json_extract_scalar('billingaddress', ['line2'], ['line2']) }} as line2,
    {{ json_extract_scalar('billingaddress', ['phone'], ['phone']) }} as phone,
    {{ json_extract_scalar('billingaddress', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('billingaddress', ['country'], ['country']) }} as country,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_scd') }} as table_alias
-- billingaddress at orders/billingAddress
where 1 = 1
and billingaddress is not null
{{ incremental_clause('_airbyte_emitted_at') }}

