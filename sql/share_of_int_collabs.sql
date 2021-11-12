WITH papers as (
SELECT 
  distinct merged_id,
  aff.country  
FROM quad_ai.ai_papers corpus  
INNER JOIN quad_ai.paper_countries aff  USING (merged_id)
WHERE 
  corpus.year >= 2010 
  and corpus.year <= 2020

), 

country_totals as (

SELECT 
  count(distinct merged_id) as total_papers, 
  country
FROM papers
GROUP BY country), 

collab_nums as (

SELECT 
  count(distinct merged_id) as num_collabs, 
  papers.country as country_a
FROM papers 
INNER JOIN 
  (SELECT 
      merged_id, 
      country as country_b 
    FROM papers) using (merged_id)
WHERE papers.country != country_b 
GROUP BY papers.country
)

SELECT 
  country, 
  total_papers, 
  num_collabs, 
  100*(num_collabs / total_papers) as percent_papers_collabed
FROM country_totals 
INNER JOIN collab_nums on country = country_a
ORDER BY total_papers desc


