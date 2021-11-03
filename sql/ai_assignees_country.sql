--getting top American assignees 

WITH patents as (
  SELECT 
  assignee, 
  year, 
  family_ID, 
  Priority_country, 
  filing_status
  FROM (
  SELECT *
    FROM
    (SELECT 
     family_id, 
     max(extract(year from publication_date)) as year
    from  quad_ai.patent_dates
    group by family_id) as patents_with_min_date 
  INNER JOIN quad_ai.patent_assignees using (family_ID)
  --CROSS JOIN UNNEST(Assignee) as assignee_unique
  ) ai
  INNER JOIN `gcp-cset-projects.unified_patents.merged_metadata` using(family_ID)
  GROUP BY year, 
    assignee, 
    family_ID, 
    Priority_country,
    filing_status

)


(SELECT 
    Priority_country, 
    assignee, 
    count(distinct family_ID) as Num_patents, 
    filing_status
FROM patents 
WHERE 
    (filing_status = 'Grant')
    and year >= 2010
    and year <= 2020
    and Priority_country = 'JP' --or "US" or "CN" or "IN" or "AU"
GROUP BY Priority_country, assignee, filing_status
ORDER BY Num_patents desc
LIMIT 25)
---------------------------JOINING WITH PATENT APPLICATIONS
UNION ALL
(SELECT 
    Priority_country, 
    assignee, 
    count(distinct family_ID) as Num_patents, 
    filing_status
FROM patents 
WHERE 
    (filing_status = 'Application')
    and year >= 2010 
    and year <= 2020
    and Priority_country = 'JP'
GROUP BY 
    Priority_country, 
    assignee, 
    filing_status
ORDER BY Num_patents desc
LIMIT 25)
