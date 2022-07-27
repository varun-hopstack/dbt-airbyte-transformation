{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_wirago_test",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('wirago_test', '_airbyte_raw_orders') }}
select
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['tote'], ['tote']) }} as tote,
    {{ json_extract_scalar('_airbyte_data', ['carrier'], ['carrier']) }} as carrier,
    {{ json_extract_scalar('_airbyte_data', ['orderId'], ['orderId']) }} as orderid,
    {{ json_extract('table_alias', '_airbyte_data', ['rawData'], ['rawData']) }} as rawdata,
    {{ json_extract_scalar('_airbyte_data', ['awbCheck'], ['awbCheck']) }} as awbcheck,
    {{ json_extract_scalar('_airbyte_data', ['reposted'], ['reposted']) }} as reposted,
    {{ json_extract_scalar('_airbyte_data', ['resolved'], ['resolved']) }} as resolved,
    {{ json_extract_scalar('_airbyte_data', ['batchKind'], ['batchKind']) }} as batchkind,
    {{ json_extract_scalar('_airbyte_data', ['orderDate'], ['orderDate']) }} as orderdate,
    {{ json_extract_scalar('_airbyte_data', ['reference'], ['reference']) }} as reference,
    {{ json_extract_scalar('_airbyte_data', ['subStatus'], ['subStatus']) }} as substatus,
    {{ json_extract('table_alias', '_airbyte_data', ['attributes'], ['attributes']) }} as attributes,
    {{ json_extract_array('_airbyte_data', ['exceptions'], ['exceptions']) }} as exceptions,
    {{ json_extract_scalar('_airbyte_data', ['manualPush'], ['manualPush']) }} as manualpush,
    {{ json_extract_scalar('_airbyte_data', ['orderValue'], ['orderValue']) }} as ordervalue,
    {{ json_extract_scalar('_airbyte_data', ['resolvedAt'], ['resolvedAt']) }} as resolvedat,
    {{ json_extract_scalar('_airbyte_data', ['shipmentId'], ['shipmentId']) }} as shipmentid,
    {{ json_extract_scalar('_airbyte_data', ['toBePosted'], ['toBePosted']) }} as tobeposted,
    {{ json_extract_scalar('_airbyte_data', ['orderStatus'], ['orderStatus']) }} as orderstatus,
    {{ json_extract_scalar('_airbyte_data', ['willResolve'], ['willResolve']) }} as willresolve,
    {{ json_extract_scalar('_airbyte_data', ['autoResolved'], ['autoResolved']) }} as autoresolved,
    {{ json_extract_array('_airbyte_data', ['messageAttrs'], ['messageAttrs']) }} as messageattrs,
    {{ json_extract_scalar('_airbyte_data', ['updatedStock'], ['updatedStock']) }} as updatedstock,
    {{ json_extract_scalar('_airbyte_data', ['completedDate'], ['completedDate']) }} as completeddate,
    {{ json_extract_scalar('_airbyte_data', ['shippingLabel'], ['shippingLabel']) }} as shippinglabel,
    {{ json_extract('table_alias', '_airbyte_data', ['billingAddress'], ['billingAddress']) }} as billingaddress,
    {{ json_extract_scalar('_airbyte_data', ['dropoffStation'], ['dropoffStation']) }} as dropoffstation,
    {{ json_extract_array('_airbyte_data', ['orderLineItems'], ['orderLineItems']) }} as orderlineitems,
    {{ json_extract_scalar('_airbyte_data', ['postedTracking'], ['postedTracking']) }} as postedtracking,
    {{ json_extract_scalar('_airbyte_data', ['trackingNumber'], ['trackingNumber']) }} as trackingnumber,
    {{ json_extract('table_alias', '_airbyte_data', ['shippingAddress'], ['shippingAddress']) }} as shippingaddress,
    {{ json_extract_scalar('_airbyte_data', ['postedCompletion'], ['postedCompletion']) }} as postedcompletion,
    {{ json_extract_scalar('_airbyte_data', ['postedTrackingAt'], ['postedTrackingAt']) }} as postedtrackingat,
    {{ json_extract_scalar('_airbyte_data', ['reprocessedLabel'], ['reprocessedLabel']) }} as reprocessedlabel,
    {{ json_extract_scalar('_airbyte_data', ['manuallyUpdatedAt'], ['manuallyUpdatedAt']) }} as manuallyupdatedat,
    {{ json_extract('table_alias', '_airbyte_data', ['stageProgressions'], ['stageProgressions']) }} as stageprogressions,
    {{ json_extract_scalar('_airbyte_data', ['checkForExceptions'], ['checkForExceptions']) }} as checkforexceptions,
    {{ json_extract_scalar('_airbyte_data', ['postedCompletionAt'], ['postedCompletionAt']) }} as postedcompletionat,
    {{ json_extract('table_alias', '_airbyte_data', ['labelGeneratedAttrs'], ['labelGeneratedAttrs']) }} as labelgeneratedattrs,
    {{ json_extract_scalar('_airbyte_data', ['willBecomeException'], ['willBecomeException']) }} as willbecomeexception,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('wirago_test', '_airbyte_raw_orders') }} as table_alias
-- orders
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

