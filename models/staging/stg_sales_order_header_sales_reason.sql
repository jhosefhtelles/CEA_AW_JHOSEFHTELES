with
    source as (
        select * from {{ source('adventure_works', 'sales_salesorderheadersalesreason') }}
    )

select
    cast(salesorderid as bigint) as salesorderid
    , cast(salesreasonid as bigint) as salesreasonid
    , cast(modifieddate as string) as modifieddate
from source