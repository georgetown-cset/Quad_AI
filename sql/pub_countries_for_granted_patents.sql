WITH patents as (
SELECT  
      year, 
      publication_country, 
      family_ID, 
      Priority_country, 
      filing_status
FROM (
SELECT *
  FROM
    (SELECT 
        family_id, 
        max(extract(year from publication_date)) as year
    FROM quad_ai.patent_dates
    GROUP BY family_id) as patents_with_min_date 
) ai
JOIN quad_ai.merged_patent_metadata using(family_id)
GROUP BY 
    year, 
    publication_country, 
    family_ID, 
    Priority_country,
    filing_status

)


SELECT 
    Priority_country, 
    Publication_country, 
    count(distinct family_id) as num_patents
FROM patents
WHERE 
    filing_status = 'Grant' 
    and year >= 2010 
    and year <= 2020
    and Priority_country = 'JP' --or "US" or "IN" or "AU"
GROUP BY 
    Priority_country, 
    Publication_country
ORDER BY 
    num_patents desc

