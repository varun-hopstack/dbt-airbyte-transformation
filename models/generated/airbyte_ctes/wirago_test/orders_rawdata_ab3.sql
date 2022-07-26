{{ config(
    sort = "_airbyte_emitted_at",
    schema = "_airbyte_wirago_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_rawdata_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_orders_hashid',
        'invoice',
        'order_id',
        'awb_image',
        'interface',
        'order_date',
        'total_item',
        'order_email',
        'order_status',
        'payment_date',
        'product_type',
        'shipping_type',
        array_to_string('order_products'),
        'payment_status',
        object_to_string('billing_address'),
        object_to_string('shipping_address'),
        'total_weight_aibyte_transform',
    ]) }} as _airbyte_rawdata_hashid,
    tmp.*
from {{ ref('orders_rawdata_ab2') }} tmp
-- rawdata at orders/rawData
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

