SELECT count(distinct merged_id) as num_papers, 
  corpus.year, 
  countries.country
FROM quad_ai.ai_papers corpus 
INNER JOIN quad_ai.paper_countries countries using (merged_id)
WHERE  
  corpus.year >= 2010 
  and corpus.year <= 2020
GROUP BY 
  corpus.year, 
  countries.country
ORDER BY 
  corpus.year, 
  num_papers desc
