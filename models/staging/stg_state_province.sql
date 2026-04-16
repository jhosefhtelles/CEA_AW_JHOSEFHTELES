with
    source as (
        select * from {{ source('adventure_works', 'person_stateprovince') }}
    )

select
    cast(stateprovinceid as bigint) as stateprovinceid
    , cast(stateprovincecode as string) as stateprovincecode
    , cast(countryregioncode as string) as countryregioncode
    , cast(isonlystateprovinceflag as boolean) as isonlystateprovinceflag
    , cast(name as string) as name
    , cast(territoryid as bigint) as territoryid
    , cast(rowguid as string) as rowguid
    , cast(modifieddate as string) as modifieddate
from source