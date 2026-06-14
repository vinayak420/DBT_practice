select * from 
--dbt_tutorial_dev.source.fact_sales
{{ ref('bronze_sales') }}
where 
    gross_amount < 0 and net_amount <0