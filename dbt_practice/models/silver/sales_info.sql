with sales as (
    select 
    sales_id, 
    product_sk, 
    customer_sk,
    {{multiply('unit_price', 'quantity')}} as calculated_amount,
    net_amount, 
    payment_method
    from 
    {{ ref('bronze_sales') }} 
),

products as (
    select
    product_sk, 
    product_code, 
    product_name, 
    category
    from 
    {{ ref('bronze_product') }}
),
customers as (
    select
    customer_sk, 
    gender
    from 
    {{ ref('bronze_customer') }} 
), 

joined_cte as (
select 

    sales.sales_id, 
    sales.calculated_amount,
    sales.net_amount, 
    sales.payment_method,
    products.product_sk, 
    products.product_code, 
    products.product_name, 
    products.category,
    customers.customer_sk, 
    customers.gender
 from
sales 
inner join 
products on 
sales.product_sk = products.product_sk
inner join 
customers on  
sales.customer_sk = customers.customer_sk)

select 
category, 
gender,
sum(net_amount) as sum_amt
from joined_cte 
group by 1,2
order by category, sum_amt desc

