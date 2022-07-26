{{ config(
    sort = "_airbyte_emitted_at",
    schema = "_airbyte_wirago_uat",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders') }}
select
    _airbyte_orders_hashid,
    {{ json_extract_scalar('rawdata', ['invoice'], ['invoice']) }} as invoice,
    {{ json_extract_scalar('rawdata', ['order_id'], ['order_id']) }} as order_id,
    {{ json_extract_scalar('rawdata', ['awb_image'], ['awb_image']) }} as awb_image,
    {{ json_extract_scalar('rawdata', ['interface'], ['interface']) }} as interface,
    {{ json_extract_scalar('rawdata', ['order_date'], ['order_date']) }} as order_date,
    {{ json_extract_scalar('rawdata', ['total_item'], ['total_item']) }} as total_item,
    {{ json_extract_scalar('rawdata', ['order_email'], ['order_email']) }} as order_email,
    {{ json_extract_scalar('rawdata', ['order_status'], ['order_status']) }} as order_status,
    {{ json_extract_scalar('rawdata', ['payment_date'], ['payment_date']) }} as payment_date,
    {{ json_extract_scalar('rawdata', ['product_type'], ['product_type']) }} as product_type,
    {{ json_extract_scalar('rawdata', ['shipping_type'], ['shipping_type']) }} as shipping_type,
    {{ json_extract_array('rawdata', ['order_products'], ['order_products']) }} as order_products,
    {{ json_extract_scalar('rawdata', ['payment_status'], ['payment_status']) }} as payment_status,
    {{ json_extract('table_alias', 'rawdata', ['billing_address'], ['billing_address']) }} as billing_address,
    {{ json_extract('table_alias', 'rawdata', ['shipping_address'], ['shipping_address']) }} as shipping_address,
    {{ json_extract_scalar('rawdata', ['total_weight_aibyte_transform'], ['total_weight_aibyte_transform']) }} as total_weight_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders') }} as table_alias
-- rawdata at orders/rawData
where 1 = 1
and rawdata is not null
{{ incremental_clause('_airbyte_emitted_at') }}

