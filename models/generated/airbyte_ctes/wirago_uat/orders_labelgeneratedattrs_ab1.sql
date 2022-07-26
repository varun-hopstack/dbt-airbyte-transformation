{{ config(
    sort = "_airbyte_emitted_at",
    schema = "_airbyte_wirago_uat",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders') }}
select
    _airbyte_orders_hashid,
    {{ json_extract_scalar('labelgeneratedattrs', ['machine'], ['machine']) }} as machine,
    {{ json_extract_scalar('labelgeneratedattrs', ['timestamp'], ['timestamp']) }} as {{ adapter.quote('timestamp') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders') }} as table_alias
-- labelgeneratedattrs at orders/labelGeneratedAttrs
where 1 = 1
and labelgeneratedattrs is not null
{{ incremental_clause('_airbyte_emitted_at') }}

