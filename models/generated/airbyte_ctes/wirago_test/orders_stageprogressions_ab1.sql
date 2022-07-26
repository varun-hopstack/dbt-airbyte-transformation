{{ config(
    sort = "_airbyte_emitted_at",
    schema = "_airbyte_wirago_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders_scd') }}
select
    _airbyte_orders_hashid,
    {{ json_extract_scalar('stageprogressions', ['CANCELLED'], ['CANCELLED']) }} as cancelled,
    {{ json_extract_scalar('stageprogressions', ['COMPLETED'], ['COMPLETED']) }} as completed,
    {{ json_extract_scalar('stageprogressions', ['EXCEPTION'], ['EXCEPTION']) }} as exception,
    {{ json_extract_scalar('stageprogressions', ['UNPROCESSED'], ['UNPROCESSED']) }} as unprocessed,
    {{ json_extract_scalar('stageprogressions', ['PACKING_STARTED'], ['PACKING_STARTED']) }} as packing_started,
    {{ json_extract_scalar('stageprogressions', ['PICKING_STARTED'], ['PICKING_STARTED']) }} as picking_started,
    {{ json_extract_scalar('stageprogressions', ['SORTING_STARTED'], ['SORTING_STARTED']) }} as sorting_started,
    {{ json_extract_scalar('stageprogressions', ['PARTIAL_COMPLETED'], ['PARTIAL_COMPLETED']) }} as partial_completed,
    {{ json_extract_scalar('stageprogressions', ['PICKING_COMPLETED'], ['PICKING_COMPLETED']) }} as picking_completed,
    {{ json_extract_scalar('stageprogressions', ['SORTING_COMPLETED'], ['SORTING_COMPLETED']) }} as sorting_completed,
    {{ json_extract_scalar('stageprogressions', ['AWAITING_CONSIGNMENT'], ['AWAITING_CONSIGNMENT']) }} as awaiting_consignment,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_scd') }} as table_alias
-- stageprogressions at orders/stageProgressions
where 1 = 1
and stageprogressions is not null
{{ incremental_clause('_airbyte_emitted_at') }}

