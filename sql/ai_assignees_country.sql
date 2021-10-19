--getting top American assignees 

WITH patents as (
  SELECT 
  assignee_unique, 
  year, 
  ai.publication_country, 
  Simple_family_ID, 
  ai.Priority_country, 
  filing_status
  FROM (
  SELECT *
    FROM
      (SELECT simple_family_id, max(extract(year from publication_date)) as year
      FROM quad_ai.ai_patent_features
      GROUP BY simple_family_id) as patents_with_min_date 
  INNER JOIN `gcp-cset-projects.1790_patents.1790_ai_patents_all_quantitative_information` using (Simple_family_ID)
  CROSS JOIN UNNEST(Assignees) as assignee_unique
  ) ai
  JOIN `gcp-cset-projects.unified_patents.merged_metadata` on family_id = cast(simple_family_id as string)
  GROUP BY year, 
  assignee_unique, 
  publication_country, 
  Simple_family_ID, 
  Priority_country,
  filing_status

)


(SELECT 
    Priority_country, 
    assignee_unique, 
    count(distinct Simple_family_ID) as Num_patents, 
    filing_status
FROM patents 
WHERE 
    (filing_status = 'Grant')
    and year >= 2005 
    and year <= 2020
    and Priority_country = 'JP' --or "US" or "CN" or "IN" or "AU"
GROUP BY Priority_country, assignee_unique, filing_status
ORDER BY Num_patents desc
LIMIT 25)
---------------------------JOINING WITH PATENT APPLICATIONS
UNION ALL
(SELECT 
    Priority_country, 
    assignee_unique, 
    count(distinct Simple_family_ID) as Num_patents, 
    filing_status
FROM patents 
WHERE 
    (filing_status = 'Application')
    and year >= 2005 
    and year <= 2020
    and Priority_country = 'JP'
GROUP BY 
    Priority_country, 
    assignee_unique, 
    filing_status
ORDER BY Num_patents desc
LIMIT 25)
