#Venture capital investment
WITH
  # table with basic company information
  comp_stage AS (
  SELECT
    * EXCEPT(short_description,
      description),
    CONCAT(coalesce(short_description, ''),' ', coalesce(description, '')) AS description
  FROM (
    SELECT
      uuid,
      name AS target_name,
      cb_url,
      country_code AS target_country,
      short_description,
      category_list,
      category_groups_list
    FROM
      gcp_cset_crunchbase.organizations )
  LEFT JOIN (
    SELECT
      uuid,
      description
    FROM
      gcp_cset_crunchbase.organization_descriptions)
  USING
    (uuid) ),
  comp AS ( # add CSET AI orgs
  SELECT
    *
  FROM
    comp_stage
  LEFT JOIN (
    SELECT
      CSET_id,
      crunchbase.crunchbase_uuid AS uuid
    FROM
      high_resolution_entities.organizations )
  USING
    (uuid) ),
  add_ipo_tab AS (
  SELECT
    uuid,
    target_name,
    cb_url,
    target_country,
    category_list,
    category_groups_list,
  IF
    (ipo IS NULL,
      0,
      ipo) AS ipo,
    shared_functions.isAICompany(description) AS ai_company,
  IF
    (category_groups_list LIKE '%Artificial Intelligence%',
      TRUE,
      FALSE) AS ai_category_cb
  FROM
    comp
  LEFT JOIN (
    SELECT
      1 AS ipo,
      org_uuid AS uuid
    FROM
      gcp_cset_crunchbase.ipos)
  USING
    (uuid) ),
  # VC funding rounds target-investor pairs
  funding_round_stage AS (
  SELECT
    target_uuid,
    investor_uuid,
    investor_name,
    org_name as target_name,
    COUNT(investor_uuid) OVER(PARTITION BY funding_round) AS n_investors,
    raised_amount_usd AS investment_value,
    investment_type,
    funding_round,
    EXTRACT(YEAR
    FROM
      announced_on) AS year
  FROM (
    SELECT
      funding_round_uuid AS funding_round,
      investor_uuid,
      investor_name
    FROM
      gcp_cset_crunchbase.investments)
  INNER JOIN (
    SELECT
      uuid AS funding_round,
      org_uuid AS target_uuid,
      org_name,
      raised_amount_usd,
      announced_on,
      investment_type
    FROM
      gcp_cset_crunchbase.funding_rounds)
  USING
    (funding_round) ),
  # add MA target-investor pairs
  # add investor country to staging round
  funding_round AS (
  SELECT
    *
  FROM
    funding_round_stage
  LEFT JOIN (
    SELECT
      uuid AS investor_uuid,
      country_code AS investor_country
    FROM
      gcp_cset_crunchbase.investors)
  USING
    (investor_uuid) ),
  add_mergers AS (
  SELECT
    target_uuid,
    investor_uuid,
    * EXCEPT(target_uuid,
      investor_uuid)
  FROM
    funding_round
  UNION ALL (
    SELECT
      acquiree_uuid AS target_uuid,
      acquirer_uuid AS investor_uuid,
      acquirer_name as investor_name,
      acquiree_name AS target_name,
      1 AS n_investors,
      price_usd AS investment_value,
      'merge' AS investment_type,
      CONCAT( acquirer_uuid,acquiree_uuid) AS funding_round,
      EXTRACT(YEAR
      FROM
        acquired_on) AS year,
      acquirer_country_code AS investor_target_country
    FROM
      gcp_cset_crunchbase.acquisitions) ),
  --    /* add ai companies to investments */ 
  add_ai_to_inv AS (
  SELECT
    * EXCEPT (target_name),
    COALESCE (a.target_name, b.target_name) as target_name
  FROM
    add_mergers a
  FULL JOIN
    add_ipo_tab b
  ON
    a.target_uuid = b.uuid),
  /* where ai_category_cb is True OR ai_company is True OR investment_from_ai_count > 0 OR investment_to_ai_count > 0*/ distinct_rounds AS (
  SELECT
    DISTINCT target_uuid,
    funding_round,
    investor_uuid,
    investment_value,
    IFNULL(investment_type,
      'missing') AS investment_type,
    uuid,
    target_name,
    investor_name,
    cb_url,
    IFNULL(target_country,
      'missing') AS target_country,
    category_list,
    category_groups_list,
    IFNULL(ipo,
      0) AS ipo,
    IFNULL(ai_company,
      FALSE) AS ai_company,
    ai_category_cb,
    IFNULL(investor_country,
      'missing') AS investor_country,
    year
  FROM
    add_ai_to_inv ),
  imp_step1 AS (
  SELECT
    * EXCEPT(imputed_investment_value_step),
    IFNULL(investment_value,
      imputed_investment_value_step) AS imputed_investment_value
  FROM (
    SELECT
      *,
      PERCENTILE_CONT(investment_value,
        0.5) OVER(PARTITION BY investment_type, ai_company, ipo, target_country, year) AS imputed_investment_value_step
    FROM
      distinct_rounds ) ),
  imp_step2 AS (
  SELECT
    * EXCEPT(imputed_investment_value,
      imputed_investment_value_step),
    IFNULL(imputed_investment_value,
      imputed_investment_value_step) AS imputed_investment_value
  FROM (
    SELECT
      *,
      PERCENTILE_CONT(investment_value,
        0.5) OVER(PARTITION BY investment_type, ai_company, target_country, year) AS imputed_investment_value_step
    FROM
      imp_step1 ) ),
  imp_step3 AS (
  SELECT
    * EXCEPT(imputed_investment_value,
      imputed_investment_value_step),
    IFNULL(imputed_investment_value,
      imputed_investment_value_step) AS imputed_investment_value
  FROM (
    SELECT
      *,
      PERCENTILE_CONT(investment_value,
        0.5) OVER(PARTITION BY investment_type, ai_company, target_country) AS imputed_investment_value_step
    FROM
      imp_step2 ) ),
  imp_step4 AS (
  SELECT
    * EXCEPT(imputed_investment_value,
      imputed_investment_value_step),
    IFNULL(imputed_investment_value,
      imputed_investment_value_step) AS imputed_investment_value
  FROM (
    SELECT
      *,
      PERCENTILE_CONT(investment_value,
        0.5) OVER(PARTITION BY ai_company, target_country) AS imputed_investment_value_step
    FROM
      imp_step3 ) ),
  imp_step5 AS (
  SELECT
    * EXCEPT(imputed_investment_value,
      imputed_investment_value_step),
    IFNULL(imputed_investment_value,
      imputed_investment_value_step) AS imputed_investment_value
  FROM (
    SELECT
      *,
      PERCENTILE_CONT(investment_value,
        0.5) OVER(PARTITION BY ai_company) AS imputed_investment_value_step
    FROM
      imp_step4 ) ),
  imp_step6 AS (
  SELECT
    * EXCEPT(imputed_investment_value,
      imputed_investment_value_step),
    IFNULL(imputed_investment_value,
      imputed_investment_value_step) AS imputed_investment_value
  FROM (
    SELECT
      *,
      PERCENTILE_CONT(investment_value,
        0.5) OVER() AS imputed_investment_value_step
    FROM
      imp_step5 ) ),
  #make QUAD AI table
  quad_ai AS (
  SELECT
  DISTINCT
    *
  FROM
    imp_step6
  WHERE
    (ai_company is TRUE 
    or ai_category_cb IS TRUE)
    AND (target_country = "USA"
      OR target_country = "AUS"
      OR target_country = "JPN"
      OR target_country = "IND"
      OR target_country = "CHN"
      OR target_country = "HKG")
    AND (year >= 2010)
    AND (year <= 2021)
    AND ( investment_type != "missing"
      AND investment_type != "debt_financing"
      AND investment_type != "equity_crowdfunding"
      AND investment_type != "grant"
      AND investment_type != "non_equity_assistance"
      AND investment_type != "post_ipo_debt"
      AND investment_type != "product_crowdfunding"
      AND investment_type != "post_ipo_debt")),
  #where investor's country code is missing, replace with people's org's country code
 people_tab AS (
  SELECT
    * EXCEPT (investor_country),
    COALESCE(CASE WHEN investor_country = "missing" THEN NULL ELSE investor_country END,
      org.country_code) AS investor_country,
  FROM
    quad_ai
  LEFT JOIN
    `gcp-cset-projects.gcp_cset_crunchbase.people` AS people
  ON
    investor_uuid = people.uuid
  LEFT JOIN
    `gcp-cset-projects.gcp_cset_crunchbase.organizations` AS org
  ON
    people.featured_job_organization_uuid = org.uuid),
  combine AS(
    # combine HKG with CHN
  SELECT
    * EXCEPT(investor_country,
      target_country),
  IF
    (investor_country = "HKG",
      "CHN",
      investor_country) AS investor_country,
  IF
    (target_country = "HKG",
      "CHN",
      target_country) AS target_country
  FROM
    people_tab)
SELECT
  DISTINCT investment_type,
  target_name,
  string_agg (investor_name, "; ") as investor_names,
  year,
  imputed_investment_value,
  investor_country,
  target_country
FROM
  combine
  where investor_country is not null
group by 
investment_type,
  target_name,
  year,
  imputed_investment_value,
  investor_country,
  target_country
order by 
target_name
