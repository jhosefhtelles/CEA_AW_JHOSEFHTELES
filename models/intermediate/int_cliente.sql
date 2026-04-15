with
    customer as (
        select *
        from {{ ref('stg_customer') }}
    )
    , person as (
        select *
        from {{ ref('stg_person') }}
    )
    , sales_order_header as (
        select *
        from {{ ref('stg_sales_order_header') }}
    )
    , credit_card as (
        select *
        from {{ ref('stg_credit_card') }}
    )
    , address as (
        select *
        from {{ ref('stg_address') }}
    )
    , state_province as (
        select *
        from {{ ref('stg_state_province') }}
    )
    , country_region as (
        select *
        from {{ ref('stg_country_region') }}
    )
    , latest_order_by_customer as (
    select
            sales_order_header.customerid
            , sales_order_header.salesorderid
            , sales_order_header.orderdate
            , sales_order_header.billtoaddressid
            , cast(sales_order_header.creditcardid as bigint) as creditcardid
            , row_number() over (
                partition by sales_order_header.customerid
                order by
                    sales_order_header.orderdate desc
                    , sales_order_header.salesorderid desc
            ) as rn
        from sales_order_header
    )
    , latest_order as (
        select *
        from latest_order_by_customer
        where rn = 1
    )
select
    customer.customerid
    , cast(customer.personid as bigint) as personid
    , person.persontype
    , person.title
    , person.firstname
    , person.middlename
    , person.lastname
    , person.suffix
    , latest_order.salesorderid as latest_salesorderid
    , latest_order.orderdate as latest_orderdate
    , credit_card.creditcardid
    , credit_card.cardtype
    , address.addressid
    , address.addressline1
    , address.addressline2
    , address.city
    , address.postalcode
    , state_province.stateprovinceid
    , state_province.stateprovincecode
    , state_province.name as stateprovince_name
    , country_region.countryregioncode
    , country_region.name as countryregion_name
from customer
left join person
    on customer.personid = person.businessentityid
left join latest_order
    on customer.customerid = latest_order.customerid
left join credit_card
    on latest_order.creditcardid = credit_card.creditcardid
left join address
    on latest_order.billtoaddressid = address.addressid
left join state_province
    on address.stateprovinceid = state_province.stateprovinceid
left join country_region
    on state_province.countryregioncode = country_region.countryregioncode
