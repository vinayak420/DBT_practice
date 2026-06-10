with dedup_cte as (select *,
row_number() over(partition by id order by updatDate desc) as dedup_key
 from 
{{ source('source', 'items') }})

select id, item, category, updatDate from dedup_cte where dedup_key = 1

