class ModelingVariable < ApplicationRecord
      
      resourcify
      audited
  belongs_to :user
  belongs_to :research_model_info

  def modeling_hash
  	target_hash = self.research_model_info.attributes
  	target_hash[:acronym] = self.research_model_info.research_variable.acronym
  	return target_hash
  end
end
