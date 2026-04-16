with
    transacoes as (
        select *
        from {{ ref('int_transacoes') }}
    )
    , cliente as (
        select *
        from {{ ref('int_cliente') }}
    )

select
    {{
        dbt_utils.generate_surrogate_key(
            [
                "cast(transacoes.salesorderid as string)"
                , "cast(transacoes.salesorderdetailid as string)"
                , "coalesce(cast(transacoes.salesreasonid as string), '')"
            ]
        )
    }} as sk_venda
    , transacoes.salesorderid as id_pedido
    , {{ dbt_utils.generate_surrogate_key(['cast(transacoes.productid as string)']) }} as fk_produto
    , {{ dbt_utils.generate_surrogate_key(['cast(transacoes.customerid as string)']) }} as fk_cliente
    , {{
        dbt_utils.generate_surrogate_key(
            [
                "coalesce(cliente.city, '')"
                , "coalesce(cliente.stateprovince_name, '')"
                , "coalesce(cliente.countryregion_name, '')"
            ]
        )
    }} as fk_localidade
    , {{ dbt_utils.generate_surrogate_key(['cast(transacoes.creditcardid as string)']) }} as fk_cartao
    , {{ dbt_utils.generate_surrogate_key(['cast(transacoes.salesreasonid as string)']) }} as fk_motivo
    , cast(transacoes.orderdate as date) as data_venda
    , transacoes.status_pedido
    , transacoes.quantidade_comprada
    , transacoes.valor_bruto
    , transacoes.valor_liquido
from transacoes
left join cliente
    on transacoes.customerid = cliente.customerid