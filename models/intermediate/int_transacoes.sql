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
    -- Agregando os motivos para evitar duplicidade (Fan-out)
    , logica_motivos as (
        select
            bridge.salesorderid
            , string_agg(sr.name, ', ') as salesreason_name
        from sales_order_reason_bridge bridge
        left join sales_reason sr
            on bridge.salesreasonid = sr.salesreasonid
        group by bridge.salesorderid
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
    -- Coluna agregada vinda da nova CTE
    , logica_motivos.salesreason_name
from sales_order_detail
inner join sales_order_header
    on sales_order_detail.salesorderid = sales_order_header.salesorderid
left join logica_motivos
    on sales_order_detail.salesorderid = logica_motivos.salesorderid