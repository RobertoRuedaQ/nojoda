class ResearchInput < ApplicationRecord
      
      resourcify
      audited

      belongs_to :research_process
end
