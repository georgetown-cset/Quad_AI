with author_country_counts as 
(
SELECT 
  count(distinct merged_id) as num_papers,
  country,  
  authors.author_name, 
  authors.author_id 
FROM quad_ai.ai_papers corpus
JOIN quad_ai.paper_countries using (merged_id)
JOIN quad_ai.paper_authors authors using (merged_id)
WHERE 
  corpus.year >= 2010 
  and corpus.year <= 2020
GROUP BY 
  country, 
  author_name,
  authors.author_id  
ORDER BY num_papers desc
), 

top_authors as (
SELECT *,
       row_number() over (partition by country order by num_papers desc) as country_rank
FROM author_country_counts
)

SELECT 
  distinct citations.country, 
  sum(n_cit) as num_citations, 
  citations.author_name, 
  citations.author_id,
  string_agg(distinct org_name) as org_names, 
  --getting top 10 for countries of interest
FROM `gcp-cset-projects.cat_data.n_citations_with_orgs` citations
INNER JOIN top_authors using (author_id)
WHERE country_rank < 11
GROUP BY 
  country, 
  author_name, 
  author_id
ORDER BY num_citations desc


