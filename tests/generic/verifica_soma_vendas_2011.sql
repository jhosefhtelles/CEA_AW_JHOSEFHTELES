{% test verifica_soma_vendas_2011(model, column_name, expected_value) %}

with calculo_soma as (
    select
        -- Arredondando a soma para 2 casas decimais para ignorar a sujeira do ponto flutuante
        round(sum({{ column_name }}), 2) as total_vendas_2011
    from {{ model }}
    where extract(year from data_venda) = 2011
)

select *
from calculo_soma
-- Compara a soma já arredondada com o valor esperado passado no YAML
where total_vendas_2011 != {{ expected_value }}

{% endtest %}