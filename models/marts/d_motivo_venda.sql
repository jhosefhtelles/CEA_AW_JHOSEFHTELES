with
    int_transacoes as (
        select distinct salesreason_name
        from {{ ref('int_transacoes') }}
        where salesreason_name is not null
    )

select
    {{ dbt_utils.generate_surrogate_key(['salesreason_name']) }} as sk_motivo
    , salesreason_name as nome_motivo
from int_transacoes