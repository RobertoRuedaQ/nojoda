class ResearchModelInfo < ApplicationRecord
      
      resourcify
      audited
  belongs_to :research_variable
  
end
