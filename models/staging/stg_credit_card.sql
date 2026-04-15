select
  cast(creditcardid as bigint) as creditcardid,
  cast(cardtype as string) as cardtype,
  cast(cardnumber as bigint) as cardnumber,
  cast(expmonth as bigint) as expmonth,
  cast(expyear as bigint) as expyear,
  cast(modifieddate as string) as modifieddate
from {{ source('adventure_works', 'sales_creditcard') }}
