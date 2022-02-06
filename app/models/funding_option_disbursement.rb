class FundingOptionDisbursement < ApplicationRecord
      
      resourcify
      audited
  belongs_to :funding_option
  belongs_to :disbursement
end
