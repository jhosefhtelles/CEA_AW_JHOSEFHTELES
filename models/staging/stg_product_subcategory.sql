with source as (
    select * from {{ source('adventure_works', 'production_productsubcategory') }}
)
select
    cast(productsubcategoryid as int) as productsubcategoryid,
    cast(productcategoryid as int) as productcategoryid,
    cast(name as string) as name,
    cast(rowguid as string) as rowguid,
    cast(modifieddate as string) as modifieddate
from source