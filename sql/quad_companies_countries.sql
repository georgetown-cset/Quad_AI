select 
    country_code,
    count(distinct uuid) as num_companies,
from gcp_cset_crunchbase.organizations
left join gcp_cset_crunchbase.organization_descriptions using (uuid)
cross join unnest (category_list_split) as categories
--ai fx for keywords 
where (cat_data.isAI(short_description) is true 
    or cat_data.isAI(description) is true 
    or categories like '%Artificial Intelligence%')
    --only companies thru 2021
    and founded_on < "2022-01-01
    --only active companies
    and closed_on is null
group by country_code 
order by num_companies desc


