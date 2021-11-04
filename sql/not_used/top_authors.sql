WITH author_country_counts as 
(
SELECT 
  count(distinct merged_id) as num_papers,
  country,  
  authors.author_name, 
  authors.author_id 
  --field_stats.level as level 
FROM quad_ai.ai_papers corpus 
JOIN quad_ai.paper_authors authors using (merged_id)
JOIN quad_ai.paper_countries countries using (merged_id)
WHERE 
  corpus.year >= 2010 
  and corpus.year <= 2020
  and author_id is not null
GROUP BY 
  country, 
  author_name,authors.author_id  
ORDER BY num_papers desc
), 

top_authors as (
SELECT *,
       row_number() over (partition by country order by num_papers desc) as country_rank
FROM author_country_counts
)

SELECT
   t.num_papers, 
   t.country, 
   t.author_name, 
   sum(n_cit) as num_citations, 
   country_rank, 
   string_agg(distinct org_name) as org_names
FROM top_authors t
LEFT JOIN quad_ai.n_citations_with_orgs using (author_id)
WHERE country_rank < 16
GROUP BY 
   t.num_papers, 
   t.country, 
   t.author_name, 
   country_rank
ORDER BY num_papers desc 


