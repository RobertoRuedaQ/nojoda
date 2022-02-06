class FundingOpportunityTeam < ApplicationRecord
      
      resourcify
      audited
  belongs_to :user
  belongs_to :funding_opportunity, touch: true
end
