with
    source as (
        select * from {{ source('adventure_works', 'sales_customer') }}
    )

select
    cast(customerid as bigint) as customerid
    , cast(personid as double) as personid
    , cast(storeid as double) as storeid
    , cast(territoryid as bigint) as territoryid
    , cast(rowguid as string) as rowguid
    , cast(modifieddate as string) as modifieddate
from source