select * from 
--dbt_tutorial_dev.source.fact_sales
{{source('source', 'fact_sales')}}