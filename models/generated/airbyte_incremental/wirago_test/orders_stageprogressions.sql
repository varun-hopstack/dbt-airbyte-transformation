{{ config(
    sort = "_airbyte_emitted_at",
    schema = "wirago_test",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_stageprogressions_ab3') }}
select
    _airbyte_orders_hashid,
    cancelled,
    completed,
    exception,
    unprocessed,
    packing_started,
    picking_started,
    sorting_started,
    partial_completed,
    picking_completed,
    sorting_completed,
    awaiting_consignment,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_stageprogressions_hashid
from {{ ref('orders_stageprogressions_ab3') }}
-- stageprogressions at orders/stageProgressions from {{ ref('orders_scd') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

