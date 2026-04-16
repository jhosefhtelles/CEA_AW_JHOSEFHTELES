with
    source as (
        select * from {{ source('adventure_works', 'person_address') }}
    )

select
    cast(addressid as bigint) as addressid
    , cast(addressline1 as string) as addressline1
    , cast(addressline2 as string) as addressline2
    , cast(city as string) as city
    , cast(stateprovinceid as bigint) as stateprovinceid
    , cast(postalcode as string) as postalcode
    , cast(spatiallocation as string) as spatiallocation
    , cast(rowguid as string) as rowguid
    , cast(modifieddate as string) as modifieddate
from source