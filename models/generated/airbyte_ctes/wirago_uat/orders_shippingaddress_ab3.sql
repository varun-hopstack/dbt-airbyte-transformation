{{ config(
    sort = "_airbyte_emitted_at",
    schema = "_airbyte_wirago_uat",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_shippingaddress_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_orders_hashid',
        'zip',
        'city',
        'name',
        'email',
        'line1',
        'line2',
        'phone',
        'state',
        'country',
    ]) }} as _airbyte_shippingaddress_hashid,
    tmp.*
from {{ ref('orders_shippingaddress_ab2') }} tmp
-- shippingaddress at orders/shippingAddress
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

