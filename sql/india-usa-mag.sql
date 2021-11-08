with ids as (

SELECT merged_id, 
    country, 
    year
FROM quad_ai.ai_papers
JOIN quad_ai.paper_countries using (merged_id)
),
--change country combinations and name as requested. see combos of Japan, USA, Australia, India
usa as (
SELECT * 
FROM ids
WHERE country = 'United States'),

india as (
SELECT * except (year)
FROM ids
WHERE 
country = "India"), 

collab as (
SELECT merged_id,  
  year,
  field_stats.name as field_name
FROM quad_ai.top_fields, unnest (fields) as field_stats 
JOIN india using (merged_id)
JOIN usa using (merged_id)
WHERE level = 1
)

SELECT field_name, 
    count(distinct if(year = 2010, merged_id, null)) _2010,
    count(distinct if(year = 2011, merged_id, null)) _2011,
    count(distinct if(year = 2012, merged_id, null)) _2012,
    count(distinct if(year = 2013, merged_id, null)) _2013,
    count(distinct if(year = 2014, merged_id, null)) _2014,
    count(distinct if(year = 2015, merged_id, null)) _2015,
    count(distinct if(year = 2016, merged_id, null)) _2016,
    count(distinct if(year = 2017, merged_id, null)) _2017,
    count(distinct if(year = 2018, merged_id, null)) _2018,
    count(distinct if(year = 2019, merged_id, null)) _2019,
    count(distinct if(year = 2020, merged_id, null)) _2020
FROM collab 
GROUP BY field_name 
