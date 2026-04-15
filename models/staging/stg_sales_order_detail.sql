select
  cast(salesorderid as bigint) as salesorderid,
  cast(salesorderdetailid as bigint) as salesorderdetailid,
  cast(carriertrackingnumber as string) as carriertrackingnumber,
  cast(orderqty as bigint) as orderqty,
  cast(productid as bigint) as productid,
  cast(specialofferid as bigint) as specialofferid,
  cast(unitprice as double) as unitprice,
  cast(unitpricediscount as double) as unitpricediscount,
  cast(rowguid as string) as rowguid,
  cast(modifieddate as string) as modifieddate
from {{ source('adventure_works', 'sales_salesorderdetail') }}
