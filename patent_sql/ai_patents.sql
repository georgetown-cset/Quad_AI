--5.9.2022
create or replace table quad_ai.ai_patents as 

select ai_patents.patent_id, 
    ai_patents.family_id, 
    year, 
    priority_country, 
    publication_country,
    filing_status
from unified_patents.ai_patents 
inner join unified_patents.merged_metadata using(patent_id)
inner join (select family_id, max(extract(year from publication_date)) as year
    from  unified_patents.patent_dates
    group by family_id) dates on ai_patents.family_id = dates.family_id
inner join unified_patents.priority_country countries on ai_patents.family_id = countries.family_id
where year >= 2010
