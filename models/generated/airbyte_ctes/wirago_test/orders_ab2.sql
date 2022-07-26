{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_wirago_test",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(tote as {{ dbt_utils.type_string() }}) as tote,
    cast(carrier as {{ dbt_utils.type_string() }}) as carrier,
    cast(orderid as {{ dbt_utils.type_float() }}) as orderid,
    cast(rawdata as {{ type_json() }}) as rawdata,
    {{ cast_to_boolean('awbcheck') }} as awbcheck,
    {{ cast_to_boolean('reposted') }} as reposted,
    {{ cast_to_boolean('resolved') }} as resolved,
    cast(batchkind as {{ dbt_utils.type_string() }}) as batchkind,
    cast(orderdate as {{ dbt_utils.type_string() }}) as orderdate,
    cast(reference as {{ dbt_utils.type_string() }}) as reference,
    cast(substatus as {{ dbt_utils.type_string() }}) as substatus,
    cast(attributes as {{ type_json() }}) as attributes,
    exceptions,
    {{ cast_to_boolean('manualpush') }} as manualpush,
    cast(ordervalue as {{ dbt_utils.type_float() }}) as ordervalue,
    cast(resolvedat as {{ dbt_utils.type_float() }}) as resolvedat,
    cast(shipmentid as {{ dbt_utils.type_string() }}) as shipmentid,
    {{ cast_to_boolean('tobeposted') }} as tobeposted,
    cast(orderstatus as {{ dbt_utils.type_string() }}) as orderstatus,
    {{ cast_to_boolean('willresolve') }} as willresolve,
    {{ cast_to_boolean('autoresolved') }} as autoresolved,
    messageattrs,
    {{ cast_to_boolean('updatedstock') }} as updatedstock,
    cast(completeddate as {{ dbt_utils.type_float() }}) as completeddate,
    cast(shippinglabel as {{ dbt_utils.type_string() }}) as shippinglabel,
    cast(billingaddress as {{ type_json() }}) as billingaddress,
    cast(dropoffstation as {{ dbt_utils.type_string() }}) as dropoffstation,
    orderlineitems,
    {{ cast_to_boolean('postedtracking') }} as postedtracking,
    cast(trackingnumber as {{ dbt_utils.type_string() }}) as trackingnumber,
    cast(shippingaddress as {{ type_json() }}) as shippingaddress,
    {{ cast_to_boolean('postedcompletion') }} as postedcompletion,
    cast(postedtrackingat as {{ dbt_utils.type_float() }}) as postedtrackingat,
    {{ cast_to_boolean('reprocessedlabel') }} as reprocessedlabel,
    cast(manuallyupdatedat as {{ dbt_utils.type_float() }}) as manuallyupdatedat,
    cast(stageprogressions as {{ type_json() }}) as stageprogressions,
    {{ cast_to_boolean('checkforexceptions') }} as checkforexceptions,
    cast(postedcompletionat as {{ dbt_utils.type_float() }}) as postedcompletionat,
    cast(labelgeneratedattrs as {{ type_json() }}) as labelgeneratedattrs,
    {{ cast_to_boolean('willbecomeexception') }} as willbecomeexception,
    cast(createdat_aibyte_transform as {{ dbt_utils.type_bigint() }}) as createdat_aibyte_transform,
    cast(updatedat_aibyte_transform as {{ dbt_utils.type_bigint() }}) as updatedat_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_ab1') }}
-- orders
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

