--grabbing assignees for quad countries

select 
    priority_country,
    count(distinct simple_family_id) as num_patents, 
    assignee_unique
from quad_ai.granted_ai_patents_1790
where 
    priority_country in ("IN", "US", "JP", "AU")
group by 
    priority_country, 
    assignee_unique
order by num_patents desc 
