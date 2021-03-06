CREATE OR REPLACE TABLE quad_ai.paper_affiliations as (
  SELECT *
  FROM `gcp-cset-projects.gcp_cset_links_v2.paper_affiliations_merged`
);

CREATE OR REPLACE TABLE quad_ai.normalized_patent_assignees as (
  SELECT *
  FROM `gcp-cset-projects.unified_patents.normalized_patent_assignees`
);

CREATE OR REPLACE TABLE quad_ai.ai_patents_1790 as (
  SELECT *
  FROM `gcp-cset-projects.1790_patents.1790_ai_patents_all_quantitative_information`
);

CREATE OR REPLACE TABLE quad_ai.paper_countries as (
  SELECT *
  FROM `gcp-cset-projects.gcp_cset_links_v2.paper_countries_merged`
);

CREATE OR REPLACE TABLE quad_ai.paper_authors as (
  SELECT *
  FROM `gcp-cset-projects.gcp_cset_links_v2.paper_authors_merged`
);

CREATE OR REPLACE TABLE quad_ai.paper_references as (
  SELECT *
  FROM gcp_cset_links_v2.paper_references_merged
);

CREATE OR REPLACE TABLE quad_ai.predictions as (
  SELECT *
  FROM `gcp-cset-projects.article_classification.predictions`
);

CREATE OR REPLACE TABLE quad_ai.corpus_merged as (
SELECT *
 FROM `gcp-cset-projects.gcp_cset_links_v2.corpus_merged` 
);

CREATE OR REPLACE TABLE quad_ai.unified_ai_patents as (
  SELECT *
  FROM `gcp-cset-projects.unified_patents.ai_patents`
);

CREATE OR REPLACE TABLE quad_ai.merged_patent_metadata as (
  SELECT *
  FROM `gcp-cset-projects.unified_patents.merged_metadata`
);

CREATE OR REPLACE TABLE quad_ai.patent_dates as (
  SELECT *
  FROM `gcp-cset-projects.unified_patents.patent_dates`
);

CREATE OR REPLACE TABLE quad_ai.top_fields as (
  SELECT *
  FROM `gcp-cset-projects.fields_of_study.top_fields`
);

CREATE OR REPLACE TABLE quad_ai.patent_dates as (
  SELECT *
  FROM `gcp-cset-projects.unified_patents.patent_dates`
);

CREATE OR REPLACE TABLE quad_ai.top_fields as (
  SELECT *
  FROM `gcp-cset-projects.fields_of_study.top_fields`
);
