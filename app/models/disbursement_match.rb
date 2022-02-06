class DisbursementMatch < ApplicationRecord
      
      resourcify
      audited
  belongs_to :disbursement, touch: true
  belongs_to :disbursement_request
end
