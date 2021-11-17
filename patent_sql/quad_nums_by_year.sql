with years as (
  select 
    distinct
    priority_country,
    simple_family_id,
    --having to grab max again to count years because cached table grabs max by doc year (ranked country counts only aggregate so don't require precision)
    max(year) as year
from quad_ai.granted_ai_patents_1790
where 
  year between 2010 and 2020 
  and priority_country in 
    ("IN", "US", 
     "AU", "JP")
group by 
  priority_country, 
  simple_family_id)

select 
    priority_country,
    count(distinct simple_family_id) as num_patents,
    year
from years
group by 
    priority_country,
    year 
order by num_patents desc 
