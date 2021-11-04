with citation_countries as (

select 
  ref_id, 
  country, 
  refs.merged_id, 
  year, 
  authors.author_name, 
  authors.author_id, 
  org_name
from quad_ai.paper_references refs
inner join quad_ai.ai_papers corpus on refs.ref_id = corpus.merged_id
inner join quad_ai.paper_authors authors on authors.merged_id = corpus.merged_id
inner join quad_ai.paper_countries countries on ref_id = countries.merged_id
   and corpus.year between 2010 and 2020
)

select 
  count(distinct merged_id) as n_cit, 
  ref_id, 
  country, 
  author_id, 
  author_name, 
  org_name, 
  year
from citation_countries
group by 
  ref_id, 
  country, 
  author_id, 
  author_name, 
  org_name, 
  year
