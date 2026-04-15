{% test verifica_soma_vendas_2011(model, column_name, expected_value) %}

    with calculo_total as (
        select
            -- Faz a soma direta (SUM) da coluna valor_bruto
            round(cast(sum({{ column_name }}) as numeric), 2) as total_bruto
        from {{ model }}
        -- Certifique-se de que a coluna de data na f_vendas se chama realmente data_venda
        where extract(year from data_venda) = 2011
    )

    -- O teste falha se a soma for diferente do esperado
    select *
    from calculo_total
    where total_bruto != {{ expected_value }}

{% endtest %}