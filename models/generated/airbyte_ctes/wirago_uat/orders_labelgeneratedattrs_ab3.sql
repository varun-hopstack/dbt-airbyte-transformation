{{ config(
    sort = "_airbyte_emitted_at",
    schema = "_airbyte_wirago_uat",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_labelgeneratedattrs_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_orders_hashid',
        'machine',
        adapter.quote('timestamp'),
    ]) }} as _airbyte_labelgeneratedattrs_hashid,
    tmp.*
from {{ ref('orders_labelgeneratedattrs_ab2') }} tmp
-- labelgeneratedattrs at orders/labelGeneratedAttrs
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

