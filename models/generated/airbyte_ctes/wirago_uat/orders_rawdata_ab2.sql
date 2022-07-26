{{ config(
    sort = "_airbyte_emitted_at",
    schema = "_airbyte_wirago_uat",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_rawdata_ab1') }}
select
    _airbyte_orders_hashid,
    cast(invoice as {{ dbt_utils.type_string() }}) as invoice,
    cast(order_id as {{ dbt_utils.type_float() }}) as order_id,
    cast(awb_image as {{ dbt_utils.type_string() }}) as awb_image,
    cast(interface as {{ dbt_utils.type_string() }}) as interface,
    cast(order_date as {{ dbt_utils.type_string() }}) as order_date,
    cast(total_item as {{ dbt_utils.type_float() }}) as total_item,
    cast(order_email as {{ dbt_utils.type_string() }}) as order_email,
    cast(order_status as {{ dbt_utils.type_float() }}) as order_status,
    cast(payment_date as {{ dbt_utils.type_string() }}) as payment_date,
    cast(product_type as {{ dbt_utils.type_string() }}) as product_type,
    cast(shipping_type as {{ dbt_utils.type_string() }}) as shipping_type,
    order_products,
    cast(payment_status as {{ dbt_utils.type_float() }}) as payment_status,
    cast(billing_address as {{ type_json() }}) as billing_address,
    cast(shipping_address as {{ type_json() }}) as shipping_address,
    cast(total_weight_aibyte_transform as {{ dbt_utils.type_string() }}) as total_weight_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_rawdata_ab1') }}
-- rawdata at orders/rawData
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

