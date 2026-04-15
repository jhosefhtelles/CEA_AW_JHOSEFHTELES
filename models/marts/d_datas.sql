with
    datas as (
        select distinct cast(orderdate as date) as data_dia
        from {{ ref('int_transacoes') }}
        where orderdate is not null
    )
select
    data_dia
    , month(data_dia) as mes
    , year(data_dia) as ano
from datas
