select
    {{ dbt_utils.generate_surrogate_key(['cast(salesreasonid as string)']) }} as sk_motivo
    , salesreasonid
    , salesreason_name as nome_motivo
from {{ ref('int_transacoes') }}
where salesreasonid is not null
group by
    1
    , 2
    , 3
