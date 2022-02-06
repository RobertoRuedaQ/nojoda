class FundingDisbursement < ApplicationRecord
      
      resourcify
      audited
      belongs_to :funding_opportunity, touch: true
end
