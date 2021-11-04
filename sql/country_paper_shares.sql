SELECT  countries.country,
  count(distinct merged_id) as num_papers, 
  --getting % of global ai papers with at least 1 author from any particular country
  100*(count(distinct merged_id)/ (SELECT count(distinct merged_id) from quad_ai.ai_papers)) as prop_papers
FROM quad_ai.ai_papers corpus 
INNER JOIN quad_ai.paper_countries countries using (merged_id)
WHERE  
  corpus.year >= 2010 
  and corpus.year <= 2020
GROUP BY 
  countries.country
ORDER BY 
  num_papers desc
