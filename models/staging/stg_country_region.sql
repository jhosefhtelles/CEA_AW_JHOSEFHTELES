select
  cast(countryregioncode as string) as countryregioncode,
  cast(name as string) as name,
  cast(modifieddate as string) as modifieddate
from {{ source('adventure_works', 'person_countryregion') }}
