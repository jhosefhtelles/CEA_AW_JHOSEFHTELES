with
    sales_order_header as (
        select *
        from {{ ref('stg_sales_order_header') }}
    )
    , sales_order_detail as (
        select *
        from {{ ref('stg_sales_order_detail') }}
    )
    , sales_order_reason_bridge as (
        select *
        from {{ ref('stg_sales_order_header_sales_reason') }}
    )
    , sales_reason as (
        select *
        from {{ ref('stg_sales_reason') }}
    )
select
    sales_order_detail.salesorderid
    , sales_order_detail.salesorderdetailid
    , sales_order_header.customerid
    , sales_order_header.orderdate
    , sales_order_header.duedate
    , sales_order_header.shipdate
    , sales_order_header.status as status_pedido
    , sales_order_header.onlineorderflag
    , sales_order_header.billtoaddressid
    , sales_order_header.shiptoaddressid
    , cast(sales_order_header.creditcardid as bigint) as creditcardid
    , sales_order_detail.productid
    , sales_order_detail.specialofferid
    , sales_order_detail.orderqty as quantidade_comprada
    , sales_order_detail.unitprice as valor_unitario
    , sales_order_detail.unitpricediscount as desconto_unitario
    , (sales_order_detail.orderqty * sales_order_detail.unitprice) as valor_bruto
    , (
        sales_order_detail.orderqty
        * sales_order_detail.unitprice
        * (1 - sales_order_detail.unitpricediscount)
    ) as valor_liquido
    , sales_order_reason_bridge.salesreasonid
    , sales_reason.name as salesreason_name
    , sales_reason.reasontype as salesreason_type
from sales_order_detail
inner join sales_order_header
    on sales_order_detail.salesorderid = sales_order_header.salesorderid
left join sales_order_reason_bridge
    on sales_order_detail.salesorderid = sales_order_reason_bridge.salesorderid
left join sales_reason
    on sales_order_reason_bridge.salesreasonid = sales_reason.salesreasonid
