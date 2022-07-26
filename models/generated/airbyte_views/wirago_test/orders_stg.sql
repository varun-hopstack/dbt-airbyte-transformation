{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_wirago_test",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'tote',
        'carrier',
        'orderid',
        object_to_string('rawdata'),
        boolean_to_string('awbcheck'),
        boolean_to_string('reposted'),
        boolean_to_string('resolved'),
        'batchkind',
        'orderdate',
        'reference',
        'substatus',
        object_to_string('attributes'),
        array_to_string('exceptions'),
        boolean_to_string('manualpush'),
        'ordervalue',
        'resolvedat',
        'shipmentid',
        boolean_to_string('tobeposted'),
        'orderstatus',
        boolean_to_string('willresolve'),
        boolean_to_string('autoresolved'),
        array_to_string('messageattrs'),
        boolean_to_string('updatedstock'),
        'completeddate',
        'shippinglabel',
        object_to_string('billingaddress'),
        'dropoffstation',
        array_to_string('orderlineitems'),
        boolean_to_string('postedtracking'),
        'trackingnumber',
        object_to_string('shippingaddress'),
        boolean_to_string('postedcompletion'),
        'postedtrackingat',
        boolean_to_string('reprocessedlabel'),
        'manuallyupdatedat',
        object_to_string('stageprogressions'),
        boolean_to_string('checkforexceptions'),
        'postedcompletionat',
        object_to_string('labelgeneratedattrs'),
        boolean_to_string('willbecomeexception'),
        'createdat_aibyte_transform',
        'updatedat_aibyte_transform',
    ]) }} as _airbyte_orders_hashid,
    tmp.*
from {{ ref('orders_ab2') }} tmp
-- orders
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

