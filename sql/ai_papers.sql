select corpus.* 
from `gcp-cset-projects.gcp_cset_links_v2.corpus_merged` corpus
inner join`gcp-cset-projects.article_classification.predictions` pred 
on cset_id = merged_id
where corpus.year >= 2010 
  and (pred.ai_filtered is true or 
       pred.nlp_filtered is true or 
       pred.cv_filtered is true or 
       pred.robotics_filtered is true)
