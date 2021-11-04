WITH 

pairwise_collabs AS

(SELECT 
  t1.merged_id, 
  t1.country as country1, 
  t2.country as country2, 
  t1.year 
FROM (
  SELECT 
      merged_id, 
      country,
      ai_papers.year
  FROM quad_ai.ai_papers
  INNER JOIN quad_ai.paper_countries 
  USING(merged_id)) AS t1 
CROSS JOIN 
 (SELECT 
      merged_id, 
      country
  FROM quad_ai.ai_papers
  INNER JOIN quad_ai.paper_countries 
  USING(merged_id)) as t2 
WHERE t1.merged_id = t2.merged_id 
AND t1.country != t2.country
--AND t1.country < t2.country
),

num_collabs as 
(SELECT 
 count(distinct merged_id) as num_collabed_papers, 
 country1, 
 country2
FROM 
  pairwise_collabs
GROUP BY 
 country1, 
 country2
ORDER BY num_collabed_papers DESC)

SELECT *
FROM num_collabs
WHERE country1 in ("United States", "Japan", "India", "Australia")
