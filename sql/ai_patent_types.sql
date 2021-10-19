--Examining breakdowns of granted AI patent families functionalities and features for select countries from 2005-2019.  

WITH
  ai_patents AS(
  SELECT
    year,
    Simple_family_ID,
    Priority_country,
    Physical_Sciences_and_Engineering,
    Life_Sciences,
    Security__eg_cybersecurity,
    Transportation,
    Industrial_and_Manufacturing,
    Education,
    Document_Mgt_and_Publishing,
    Military,
    Agricultural,
    Computing_in_Government,
    Personal_Devices_and_Computing,
    Banking_and_Finance,
    Telecommunications,
    Networks__eg_social_IOT_etc,
    Business,
    Energy_Management,
    Entertainment,
    Nanotechnology,
    Semiconductors,
    Language_Processing,
    Speech_Processing,
    Knowledge_Representation,
    Planning_and_Scheduling,
    Control,
    Distributed_AI,
    Robotics,
    Computer_Vision,
    Analytics_and_Algorithms,
    Measuring_and_Testing,
    Logic_Programming,
    Fuzzy_Logic,
    Probabilistic_Reasoning,
    Ontology_Engineering,
    Machine_Learning,
    Search_Methods,
    Generic_and_Unspecified,
    filing_status
  FROM
    (SELECT 
      simple_family_id, 
      max(extract(year from publication_date)) as year
    FROM quad_ai.ai_patent_features
   GROUP BY 
      simple_family_id) as patents_with_min_date 
 INNER JOIN quad_ai.ai_patent_features
 using (Simple_family_ID)
 INNER JOIN 
      (SELECT family_id, 
        filing_status 
       FROM quad_ai.merged_patent_metadata)
      on cast(family_id as string) = cast(simple_family_id as string)
  GROUP BY
    filing_status,
    Priority_country,
    year,
    Simple_family_ID,
    Physical_Sciences_and_Engineering,
    Life_Sciences,
    Security__eg_cybersecurity,
    Transportation,
    Industrial_and_Manufacturing,
    Education,
    Document_Mgt_and_Publishing,
    Military,
    Agricultural,
    Computing_in_Government,
    Personal_Devices_and_Computing,
    Banking_and_Finance,
    Telecommunications,
    Networks__eg_social_IOT_etc,
    Business,
    Energy_Management,
    Entertainment,
    Nanotechnology,
    Semiconductors,
    Language_Processing,
    Speech_Processing,
    Knowledge_Representation,
    Planning_and_Scheduling,
    Control,
    Distributed_AI,
    Robotics,
    Computer_Vision,
    Analytics_and_Algorithms,
    Measuring_and_Testing,
    Logic_Programming,
    Fuzzy_Logic,
    Probabilistic_Reasoning,
    Ontology_Engineering,
    Machine_Learning,
    Search_Methods,
    Generic_and_Unspecified)
SELECT
  Priority_country,
  count(distinct
  IF
    (Physical_Sciences_and_Engineering IS TRUE,
      Simple_family_ID,
      null)) AS Physical_Sciences_and_Engineering,
  count(distinct
  IF
    (Life_Sciences IS TRUE,
      Simple_family_ID,
      null)) AS Life_Sciences,
  count(distinct
  IF
    (Security__eg_cybersecurity IS TRUE,
      Simple_family_ID,
      null)) AS Security__eg_cybersecurity,
  count(distinct
  IF
    (Transportation IS TRUE,
      Simple_family_ID,
      null)) AS Transportation,
  count(distinct
  IF
    (Industrial_and_Manufacturing IS TRUE,
      Simple_family_ID,
      null)) AS Industrial_and_Manufacturing,
  count(distinct
  IF
    (Education IS TRUE,
      Simple_family_ID,
      null)) AS Education,
  count(distinct
  IF
    (Document_Mgt_and_Publishing IS TRUE,
      Simple_family_ID,
      null)) AS Document_Mgt_and_Publishing,
  count(distinct
  IF
    (Military IS TRUE,
      Simple_family_ID,
      null)) AS Military,
  count(distinct
  IF
    (Agricultural IS TRUE,
      Simple_family_ID,
      null)) AS Agricultural,
  count(distinct
  IF
    (Computing_in_Government IS TRUE,
      Simple_family_ID,
      null)) AS Computing_in_Government,
  count(distinct
  IF
    (Personal_Devices_and_Computing IS TRUE,
      Simple_family_ID,
      null)) AS Personal_Devices_and_Computing,
  count(distinct
  IF
    (Banking_and_Finance IS TRUE,
      Simple_family_ID,
      null)) AS Banking_and_Finance,
  count(distinct
  IF
    (Telecommunications IS TRUE,
      Simple_family_ID,
      null)) AS Telecommunications,
  count(distinct
  IF
    (Networks__eg_social_IOT_etc IS TRUE,
      Simple_family_ID,
      null)) AS Networks__eg_social_IOT_etc,
  count(distinct
  IF
    (Business IS TRUE,
      Simple_family_ID,
      null)) AS Business,
  count(distinct
  IF
    (Energy_Management IS TRUE,
      Simple_family_ID,
      null)) AS Energy_Management,
  count(distinct
  IF
    (Entertainment IS TRUE,
      Simple_family_ID,
      null)) AS Entertainment,
  count(distinct
  IF
    (Nanotechnology IS TRUE,
      Simple_family_ID,
      null)) AS Nanotechnology,
  count(distinct
  IF
    (Semiconductors IS TRUE,
      Simple_family_ID,
      null)) AS Semiconductors,
  count(distinct
  IF
    (Language_Processing IS TRUE,
      Simple_family_ID,
      null)) AS Language_Processing,
  count(distinct
  IF
    (Speech_Processing IS TRUE,
      Simple_family_ID,
      null)) AS Speech_Processing,
  count(distinct
  IF
    (Knowledge_Representation IS TRUE,
      Simple_family_ID,
      null)) AS Knowledge_Representation,
  count(distinct
  IF
    (Planning_and_Scheduling IS TRUE,
      Simple_family_ID,
      null)) AS Planning_and_Scheduling,
  count(distinct
  IF
    (Control IS TRUE,
      Simple_family_ID,
      null)) AS Control,
  count(distinct
  IF
    (Distributed_AI IS TRUE,
      Simple_family_ID,
      null)) AS Distributed_AI,
  count(distinct
  IF
    (Robotics IS TRUE,
      Simple_family_ID,
      null)) AS Robotics,
  count(distinct
  IF
    (Computer_Vision IS TRUE,
      Simple_family_ID,
      null)) AS Computer_Vision,
  count(distinct
  IF
    (Analytics_and_Algorithms IS TRUE,
      Simple_family_ID,
      null)) AS Analytics_and_Algorithms,
  count(distinct
  IF
    (Measuring_and_Testing IS TRUE,
      Simple_family_ID,
      null)) AS Measuring_and_Testing,
  count(distinct
  IF
    (Logic_Programming IS TRUE,
      Simple_family_ID,
      null)) AS Logic_Programming,
  count(distinct
  IF
    (Fuzzy_Logic IS TRUE,
      Simple_family_ID,
      null)) AS Fuzzy_Logic,
  count(distinct
  IF
    (Probabilistic_Reasoning IS TRUE,
      Simple_family_ID,
      null)) AS Probabilistic_Reasoning,
  count(distinct
  IF
    (Ontology_Engineering IS TRUE,
      Simple_family_ID,
      null)) AS Ontology_Engineering,
  count(distinct
  IF
    (Machine_Learning IS TRUE,
      Simple_family_ID,
      null)) AS Machine_Learning,
  count(distinct
  IF
    (Search_Methods IS TRUE,
      Simple_family_ID,
      null)) AS Search_Methods,
  count(distinct
  IF
    (Generic_and_Unspecified IS TRUE,
      Simple_family_ID,
      null)) AS Generic_and_Unspecified,
FROM
  ai_patents
WHERE
  year >= 2005
  AND filing_status = 'Grant'
  --AND Priority_country in 
--('IN', 'US', 'AU', 'CN', 'JP', 'KR', 'NZ')
GROUP BY
  Priority_country
