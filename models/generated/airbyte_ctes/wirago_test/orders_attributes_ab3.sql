{{ config(
    sort = "_airbyte_emitted_at",
    schema = "_airbyte_wirago_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_attributes_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_orders_hashid',
        'email',
        'interface',
        'weight_aibyte_transform',
    ]) }} as _airbyte_attributes_hashid,
    tmp.*
from {{ ref('orders_attributes_ab2') }} tmp
-- attributes at orders/attributes
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

