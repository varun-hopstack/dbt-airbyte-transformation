{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "wirago_uat",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_ab3') }}
select
    _id,
    tote,
    carrier,
    orderid,
    rawdata,
    awbcheck,
    reposted,
    resolved,
    batchkind,
    orderdate,
    reference,
    substatus,
    attributes,
    exceptions,
    manualpush,
    ordervalue,
    resolvedat,
    shipmentid,
    tobeposted,
    orderstatus,
    willresolve,
    autoresolved,
    messageattrs,
    updatedstock,
    completeddate,
    shippinglabel,
    billingaddress,
    dropoffstation,
    orderlineitems,
    postedtracking,
    trackingnumber,
    shippingaddress,
    postedcompletion,
    postedtrackingat,
    reprocessedlabel,
    manuallyupdatedat,
    stageprogressions,
    checkforexceptions,
    postedcompletionat,
    labelgeneratedattrs,
    willbecomeexception,
    createdat_aibyte_transform,
    updatedat_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_orders_hashid
from {{ ref('orders_ab3') }}
-- orders from {{ source('wirago_uat', '_airbyte_raw_orders') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

