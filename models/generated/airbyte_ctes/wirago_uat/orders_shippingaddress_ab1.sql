{{ config(
    sort = "_airbyte_emitted_at",
    schema = "_airbyte_wirago_uat",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders') }}
select
    _airbyte_orders_hashid,
    {{ json_extract_scalar('shippingaddress', ['zip'], ['zip']) }} as zip,
    {{ json_extract_scalar('shippingaddress', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('shippingaddress', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('shippingaddress', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('shippingaddress', ['line1'], ['line1']) }} as line1,
    {{ json_extract_scalar('shippingaddress', ['line2'], ['line2']) }} as line2,
    {{ json_extract_scalar('shippingaddress', ['phone'], ['phone']) }} as phone,
    {{ json_extract_scalar('shippingaddress', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('shippingaddress', ['country'], ['country']) }} as country,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders') }} as table_alias
-- shippingaddress at orders/shippingAddress
where 1 = 1
and shippingaddress is not null
{{ incremental_clause('_airbyte_emitted_at') }}

