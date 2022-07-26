{{ config(
    sort = "_airbyte_emitted_at",
    schema = "_airbyte_wirago_uat",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders_rawdata') }}
select
    _airbyte_rawdata_hashid,
    {{ json_extract_scalar('shipping_address', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('shipping_address', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('shipping_address', ['phone'], ['phone']) }} as phone,
    {{ json_extract_scalar('shipping_address', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('shipping_address', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('shipping_address', ['order_id'], ['order_id']) }} as order_id,
    {{ json_extract_scalar('shipping_address', ['post_code'], ['post_code']) }} as post_code,
    {{ json_extract_scalar('shipping_address', ['address_line1'], ['address_line1']) }} as address_line1,
    {{ json_extract_scalar('shipping_address', ['address_line2'], ['address_line2']) }} as address_line2,
    {{ json_extract_scalar('shipping_address', ['receiver_name'], ['receiver_name']) }} as receiver_name,
    {{ json_extract_scalar('shipping_address', ['shipping_address_id'], ['shipping_address_id']) }} as shipping_address_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_rawdata') }} as table_alias
-- shipping_address at orders/rawData/shipping_address
where 1 = 1
and shipping_address is not null
{{ incremental_clause('_airbyte_emitted_at') }}

