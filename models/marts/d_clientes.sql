with
    int_cliente as (
        select *
        from {{ ref('int_cliente') }}
    )

select
    {{ dbt_utils.generate_surrogate_key(['cast(customerid as string)']) }} as sk_cliente
    , customerid
    , trim(coalesce(firstname, '') || ' ' || coalesce(lastname, '')) as nome_cliente
from int_cliente