with top_fields as (
select count(distinct merged_id) as num_papers, 
    field_stats.name as field_name
from quad_ai.top_fields , unnest (fields) as field_stats
inner join quad_ai.ai_papers using(merged_id)
group by field_name
order by num_papers desc 
limit 20
)

select field_name 
from top_fields
