select 
    country_code,
    count(distinct uuid) as num_companies,
from gcp_cset_crunchbase.organizations
cross join unnest (category_list_split) as categories
--ai fx for keywords 
where (cat_data.isAI(short_description) is true 
    or categories like '%Artificial Intelligence%')
    --only companies thru 2021
    and founded_on < "2022-01-01" #without this  61449 as of 2-10-2022
    --only active companies
    and closed_on is null
group by country_code 
order by num_companies desc
