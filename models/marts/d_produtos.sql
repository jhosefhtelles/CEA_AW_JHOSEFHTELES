with
    stg_product as (
        select *
        from {{ ref('stg_product') }}
    )
    , stg_product_subcategory as (
        select *
        from {{ ref('stg_product_subcategory') }}
    )
    , stg_product_category as (
        select *
        from {{ ref('stg_product_category') }}
    )

select
    {{ dbt_utils.generate_surrogate_key(['cast(stg_product.productid as string)']) }} as sk_produto
    , stg_product.productid
    , stg_product.name as nome_produto
    -- Ajustado: stg_product_subcategory.name vira nome_subcategoria
    , coalesce(stg_product_subcategory.name, 'Sem Subcategoria') as nome_subcategoria
    -- Ajustado: stg_product_category.name vira nome_categoria
    , coalesce(stg_product_category.name, 'Sem Categoria') as nome_categoria
from stg_product
left join stg_product_subcategory
    on stg_product.productsubcategoryid = stg_product_subcategory.productsubcategoryid
left join stg_product_category
    on stg_product_subcategory.productcategoryid = stg_product_category.productcategoryid