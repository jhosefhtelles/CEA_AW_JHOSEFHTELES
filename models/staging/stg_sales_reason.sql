with
    source as (
        select * from {{ source('adventure_works', 'sales_salesreason') }}
    )

select
    cast(salesreasonid as bigint) as salesreasonid
    , cast(name as string) as name
    , cast(reasontype as string) as reasontype
    , cast(modifieddate as string) as modifieddate
from source