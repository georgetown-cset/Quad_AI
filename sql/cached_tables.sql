CREATE OR REPLACE TABLE quad_ai.paper_affiliations_18102021 as (
  SELECT *
  FROM `gcp-cset-projects.gcp_cset_links_v2.paper_affiliations_merged`
);

CREATE OR REPLACE TABLE quad_ai.paper_countries_18102021 as (
  SELECT *
  FROM `gcp-cset-projects.gcp_cset_links_v2.paper_countries_merged`
);

CREATE OR REPLACE TABLE quad_ai.unified_ai_patents_18102021 as (
  SELECT *
  FROM `gcp-cset-projects.unified_patents.ai_patents`
);

CREATE OR REPLACE TABLE quad_ai.merged_patent_metadata_18102021 as (
  SELECT *
  FROM `gcp-cset-projects.unified_patents.merged_metadata`
);

CREATE OR REPLACE TABLE quad_ai.patent_dates_18102021 as (
  SELECT *
  FROM `gcp-cset-projects.unified_patents.patent_dates`
);

CREATE OR REPLACE TABLE quad_ai.top_fields_18102021 as (
  SELECT *
  FROM `gcp-cset-projects.fields_of_study.top_fields`
);
