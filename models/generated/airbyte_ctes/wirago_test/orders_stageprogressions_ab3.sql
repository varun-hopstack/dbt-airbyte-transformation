{{ config(
    sort = "_airbyte_emitted_at",
    schema = "_airbyte_wirago_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_stageprogressions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_orders_hashid',
        'cancelled',
        'completed',
        'exception',
        'unprocessed',
        'packing_started',
        'picking_started',
        'sorting_started',
        'partial_completed',
        'picking_completed',
        'sorting_completed',
        'awaiting_consignment',
    ]) }} as _airbyte_stageprogressions_hashid,
    tmp.*
from {{ ref('orders_stageprogressions_ab2') }} tmp
-- stageprogressions at orders/stageProgressions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

