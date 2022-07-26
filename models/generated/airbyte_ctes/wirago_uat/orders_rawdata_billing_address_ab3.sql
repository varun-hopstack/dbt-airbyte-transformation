{{ config(
    sort = "_airbyte_emitted_at",
    schema = "_airbyte_wirago_uat",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_rawdata_billing_address_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_rawdata_hashid',
        'city',
        'phone',
        'state',
        'country',
        'order_id',
        'last_name',
        'post_code',
        'first_name',
        'address_line1',
        'address_line2',
        'billing_address_id',
    ]) }} as _airbyte_billing_address_hashid,
    tmp.*
from {{ ref('orders_rawdata_billing_address_ab2') }} tmp
-- billing_address at orders/rawData/billing_address
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

