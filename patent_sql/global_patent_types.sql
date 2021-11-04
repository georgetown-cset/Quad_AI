with ai_types as (

select 
    year,
    granted.simple_family_id, 
    granted.document_id_number, 
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
    Generic_and_Unspecified
from quad_ai.granted_ai_patents_1790 granted
join quad_ai.ai_patents_1790 using(simple_family_id)
where 
    granted.year between 2010 and 2020
group by 
    year,
    simple_family_id, 
    document_id_number, 
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
    Generic_and_Unspecified

)

SELECT
  year,
  count(distinct
  IF
    (Physical_Sciences_and_Engineering IS TRUE,
      simple_family_ID,
      null)) AS Physical_Sciences_and_Engineering,
  count(distinct
  IF
    (Life_Sciences IS TRUE,
      simple_family_ID,
      null)) AS Life_Sciences,
  count(distinct
  IF
    (Security__eg_cybersecurity IS TRUE,
      simple_family_ID,
      null)) AS Security__eg_cybersecurity,
  count(distinct
  IF
    (Transportation IS TRUE,
      simple_family_ID,
      null)) AS Transportation,
  count(distinct
  IF
    (Industrial_and_Manufacturing IS TRUE,
      simple_family_ID,
      null)) AS Industrial_and_Manufacturing,
  count(distinct
  IF
    (Education IS TRUE,
      simple_family_ID,
      null)) AS Education,
  count(distinct
  IF
    (Document_Mgt_and_Publishing IS TRUE,
      simple_family_ID,
      null)) AS Document_Mgt_and_Publishing,
  count(distinct
  IF
    (Military IS TRUE,
      simple_family_ID,
      null)) AS Military,
  count(distinct
  IF
    (Agricultural IS TRUE,
      simple_family_ID,
      null)) AS Agricultural,
  count(distinct
  IF
    (Computing_in_Government IS TRUE,
      simple_family_ID,
      null)) AS Computing_in_Government,
  count(distinct
  IF
    (Personal_Devices_and_Computing IS TRUE,
      simple_family_ID,
      null)) AS Personal_Devices_and_Computing,
  count(distinct
  IF
    (Banking_and_Finance IS TRUE,
      simple_family_ID,
      null)) AS Banking_and_Finance,
  count(distinct
  IF
    (Telecommunications IS TRUE,
      simple_family_ID,
      null)) AS Telecommunications,
  count(distinct
  IF
    (Networks__eg_social_IOT_etc IS TRUE,
      simple_family_ID,
      null)) AS Networks__eg_social_IOT_etc,
  count(distinct
  IF
    (Business IS TRUE,
      simple_family_ID,
      null)) AS Business,
  count(distinct
  IF
    (Energy_Management IS TRUE,
      simple_family_ID,
      null)) AS Energy_Management,
  count(distinct
  IF
    (Entertainment IS TRUE,
      simple_family_ID,
      null)) AS Entertainment,
  count(distinct
  IF
    (Nanotechnology IS TRUE,
      simple_family_ID,
      null)) AS Nanotechnology,
  count(distinct
  IF
    (Semiconductors IS TRUE,
      simple_family_ID,
      null)) AS Semiconductors,
  count(distinct
  IF
    (Language_Processing IS TRUE,
      simple_family_ID,
      null)) AS Language_Processing,
  count(distinct
  IF
    (Speech_Processing IS TRUE,
      simple_family_ID,
      null)) AS Speech_Processing,
  count(distinct
  IF
    (Knowledge_Representation IS TRUE,
      simple_family_ID,
      null)) AS Knowledge_Representation,
  count(distinct
  IF
    (Planning_and_Scheduling IS TRUE,
      simple_family_ID,
      null)) AS Planning_and_Scheduling,
  count(distinct
  IF
    (Control IS TRUE,
      simple_family_ID,
      null)) AS Control,
  count(distinct
  IF
    (Distributed_AI IS TRUE,
      simple_family_ID,
      null)) AS Distributed_AI,
  count(distinct
  IF
    (Robotics IS TRUE,
      simple_family_ID,
      null)) AS Robotics,
  count(distinct
  IF
    (Computer_Vision IS TRUE,
      simple_family_ID,
      null)) AS Computer_Vision,
  count(distinct
  IF
    (Analytics_and_Algorithms IS TRUE,
      simple_family_ID,
      null)) AS Analytics_and_Algorithms,
  count(distinct
  IF
    (Measuring_and_Testing IS TRUE,
      simple_family_ID,
      null)) AS Measuring_and_Testing,
  count(distinct
  IF
    (Logic_Programming IS TRUE,
      simple_family_ID,
      null)) AS Logic_Programming,
  count(distinct
  IF
    (Fuzzy_Logic IS TRUE,
      simple_family_ID,
      null)) AS Fuzzy_Logic,
  count(distinct
  IF
    (Probabilistic_Reasoning IS TRUE,
      simple_family_ID,
      null)) AS Probabilistic_Reasoning,
  count(distinct
  IF
    (Ontology_Engineering IS TRUE,
      simple_family_ID,
      null)) AS Ontology_Engineering,
  count(distinct
  IF
    (Machine_Learning IS TRUE,
      simple_family_ID,
      null)) AS Machine_Learning,
  count(distinct
  IF
    (Search_Methods IS TRUE,
      simple_family_ID,
      null)) AS Search_Methods,
  count(distinct
  IF
    (Generic_and_Unspecified IS TRUE,
      simple_family_ID,
      null)) AS Generic_and_Unspecified,
FROM
  ai_types
GROUP BY 
    year
ORDER BY 
    year
