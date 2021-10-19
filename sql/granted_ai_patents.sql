SELECT count(distinct family_id) as num_patents, 
    year, 
    priority_country
FROM quad_ai.unified_ai_patents
INNER JOIN 
(SELECT family_id, max(extract(year from first_priority_date)) as year
    from  quad_ai.patent_dates
    group by family_id) using(family_id)
INNER JOIN quad_ai.merged_patent_metadata using
  (family_id)
WHERE filing_status = "Grant" and 
    priority_country is not null
    and year > 2009 
GROUP BY 
  year, 
  priority_country
