with
    source as (
        select * from {{ source('adventure_works', 'person_person') }}
    )

select
    cast(businessentityid as bigint) as businessentityid
    , cast(persontype as string) as persontype
    , cast(namestyle as boolean) as namestyle
    , cast(title as string) as title
    , cast(firstname as string) as firstname
    , cast(middlename as string) as middlename
    , cast(lastname as string) as lastname
    , cast(suffix as string) as suffix
    , cast(emailpromotion as bigint) as emailpromotion
    , cast(additionalcontactinfo as string) as additionalcontactinfo
    , cast(demographics as string) as demographics
    , cast(rowguid as string) as rowguid
    , cast(modifieddate as string) as modifieddate
from source