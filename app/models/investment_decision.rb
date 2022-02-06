class InvestmentDecision < ApplicationRecord
      
      resourcify
      audited
  belongs_to :invest_committee
  belongs_to :funding_option
  belongs_to :user, touch: true
end
