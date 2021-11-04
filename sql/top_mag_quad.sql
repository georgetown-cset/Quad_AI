SELECT count(distinct merged_id) as num_papers,  
  aff.country,  
  case when field_stats.name 
  in 
  --from table where we order the top global mag ai fields
    (select * 
    from quad_ai.top_mag_ai)
   then field_stats.name else 
     ("Other AI") end as field_name 
FROM quad_ai.top_fields, unnest (fields) as field_stats 
JOIN quad_ai.ai_papers corpus using (merged_id) 
JOIN quad_ai.paper_countries aff  USING (merged_id)
WHERE level = 1
  and corpus.year >= 2010 
  and corpus.year <= 2020
  and country in ("India", "United States", "Australia", "Japan")
GROUP BY 
    aff.country, 
    field_name 
ORDER BY 
    num_papers desc

