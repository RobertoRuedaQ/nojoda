class CustomDisbursement < ApplicationRecord
      
      resourcify
      audited
  belongs_to :modeling
  belongs_to :funding_token
end
