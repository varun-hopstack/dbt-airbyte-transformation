{{ config(
    sort = "_airbyte_emitted_at",
    schema = "_airbyte_wirago_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_rawdata_shipping_address_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_rawdata_hashid',
        'city',
        'email',
        'phone',
        'state',
        'country',
        'order_id',
        'post_code',
        'address_line1',
        'address_line2',
        'receiver_name',
        'shipping_address_id',
    ]) }} as _airbyte_shipping_address_hashid,
    tmp.*
from {{ ref('orders_rawdata_shipping_address_ab2') }} tmp
-- shipping_address at orders/rawData/shipping_address
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

