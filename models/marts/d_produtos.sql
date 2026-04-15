select
    {{ dbt_utils.generate_surrogate_key(['cast(productid as string)']) }} as sk_produto
    , productid
    , name as nome_produto
from {{ ref('stg_product') }}
