class ResearchProcess < ApplicationRecord
  include LumniModeling
  resourcify
  audited

  has_many :research_input,dependent: :destroy
  has_many :modeling

  def run_research_process target_params 
  	case self.action
  	when 'modeling_with_r'
    	@response = request_r_modeling target_params,self.action,self.url
  	end
  	return @response
  end


end
