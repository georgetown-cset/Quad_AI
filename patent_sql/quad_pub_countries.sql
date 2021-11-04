select 
    priority_country,
    count(distinct simple_family_id) as num_patents, 
    publication_country
from quad_ai.granted_ai_patents_1790
where 
    priority_country in ("IN", "US", "JP", "AU")
    and year between 2010 and 2020
group by 
    priority_country, 
    publication_country
order by num_patents desc 
