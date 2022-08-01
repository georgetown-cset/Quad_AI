--5.9.2022
create or replace table quad_ai.ai_patents as 

select ai_patents.patent_id, 
    ai_patents.family_id, 
    year, 
    priority_country, 
    publication_country,
    case when (publication_country in ("JP") and legal_status in ("Active", "Expired - Fee Related", "Expired - Lifetime", "Expired")) 
  then "Grant" 
  when publication_country in ("CN") and legal_status in ('Active', "Expired - Fee Related", "Expired - Lifetime", 'Withdrawn-After Issue',
    'Active-Reinstated','Revoked') 
    ###note we are missing about 13,000 "Ceased" Chinese patents with this method, but that is almost exactly negated by 13,000 FP "Expired-Lifetime" Chinese patent grants, so we would expect this number to be still almost exactly correct for China. 
  then "Grant" else filing_status end filing_status
from unified_patents.ai_patents 
inner join unified_patents.merged_metadata using(patent_id)
inner join (select family_id, max(extract(year from first_priority_date)) as year
    from  unified_patents.patent_dates
    group by family_id) dates on ai_patents.family_id = dates.family_id
inner join unified_patents.priority_country countries on ai_patents.patent_id = countries.patent_id
where year between 2010 and 2021
