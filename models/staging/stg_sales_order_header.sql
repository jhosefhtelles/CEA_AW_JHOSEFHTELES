with
    source as (
        select * from {{ source('adventure_works', 'sales_salesorderheader') }}
    )

select
    cast(salesorderid as bigint) as salesorderid
    , cast(revisionnumber as bigint) as revisionnumber
    , cast(orderdate as string) as orderdate
    , cast(duedate as string) as duedate
    , cast(shipdate as string) as shipdate
    , cast(status as bigint) as status
    , cast(onlineorderflag as boolean) as onlineorderflag
    , cast(purchaseordernumber as string) as purchaseordernumber
    , cast(accountnumber as string) as accountnumber
    , cast(customerid as bigint) as customerid
    , cast(salespersonid as double) as salespersonid
    , cast(territoryid as bigint) as territoryid
    , cast(billtoaddressid as bigint) as billtoaddressid
    , cast(shiptoaddressid as bigint) as shiptoaddressid
    , cast(shipmethodid as bigint) as shipmethodid
    , cast(creditcardid as double) as creditcardid
    , cast(creditcardapprovalcode as string) as creditcardapprovalcode
    , cast(currencyrateid as double) as currencyrateid
    , cast(subtotal as double) as subtotal
    , cast(taxamt as double) as taxamt
    , cast(freight as double) as freight
    , cast(totaldue as double) as totaldue
    , cast(comment as double) as comment
    , cast(rowguid as string) as rowguid
    , cast(modifieddate as string) as modifieddate
from source