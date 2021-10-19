WITH patents as (
SELECT  
      year, 
      ai.publication_country, 
      Simple_family_ID, 
      ai.Priority_country, 
      filing_status
FROM (
SELECT *
  FROM
    (SELECT 
        simple_family_id, 
        max(extract(year from publication_date)) as year
    FROM quad_ai.ai_patent_features
    GROUP BY simple_family_id) as patents_with_min_date 
INNER JOIN quad_ai.ai_patent_features using (Simple_family_ID)
) ai
JOIN quad_ai.merged_patent_metadata on family_id = cast(simple_family_id as string)
GROUP BY 
    year, 
    publication_country, 
    Simple_family_ID, 
    Priority_country,
    filing_status

)


SELECT 
    Priority_country, 
    Publication_country, 
    count(distinct simple_family_id) as num_patents
FROM patents
WHERE 
    filing_status = 'Grant' 
    and year >= 2005 
    and year <= 2020
    and Priority_country = 'JP' -- change to "IN", "US", "AU" for India, USA, Australia, respectively 
GROUP BY 
    Priority_country, 
    Publication_country
ORDER BY 
    num_patents desc

