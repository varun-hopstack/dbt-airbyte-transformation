{{ config(
    sort = "_airbyte_emitted_at",
    schema = "wirago_uat",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_rawdata_billing_address_ab3') }}
select
    _airbyte_rawdata_hashid,
    city,
    phone,
    state,
    country,
    order_id,
    last_name,
    post_code,
    first_name,
    address_line1,
    address_line2,
    billing_address_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_billing_address_hashid
from {{ ref('orders_rawdata_billing_address_ab3') }}
-- billing_address at orders/rawData/billing_address from {{ ref('orders_rawdata') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

