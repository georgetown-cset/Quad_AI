

WITH 
  citation_countries as (
select 
  ref_id, 
  country, 
  refs.merged_id
from quad_ai.paper_references refs
join quad_ai.paper_countries countries on ref_id = countries.merged_id
join quad_ai.ai_papers on corpus.merged_id = ref_id
), 


n_citations as (
select count(merged_id) as n_cit, 
  ref_id, 
  country, 
  row_number() over 
     ( 
         partition by country
         order by count(merged_id) desc
     ) AS rankings 
from citation_countries
group by 
  ref_id, 
  country
order by n_cit desc
),

raw_ids as (
select 
  ref_id, 
  country, 
  sum(n_cit) as num_citations 
from n_citations
where rankings <11
group by 
  ref_id, 
  country
order by 
  country, 
  num_citations desc
)

select 
  raw_ids.*, 
  corpus.year, 
  corpus.title_english, 
  corpus.source_title
from raw_ids 
inner join gcp_cset_links_v2.corpus_merged corpus on ref_id = merged_id
