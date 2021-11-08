SELECT  
--getting total no of AI papers with at least 1 quad author and getting its global share
  count(distinct merged_id) as num_papers, 
  (count(distinct merged_id)/ (SELECT count(distinct merged_id) from quad_ai.ai_papers)) as prop_papers
FROM quad_ai.ai_papers corpus 
INNER JOIN quad_ai.paper_countries countries using (merged_id)
WHERE  
  corpus.year >= 2010 
  and corpus.year <= 2020
  --also analyzed for list of EU countries and ASEAN
  and country in ("India", "United States", "Australia", "Japan")
ORDER BY 
  num_papers desc
