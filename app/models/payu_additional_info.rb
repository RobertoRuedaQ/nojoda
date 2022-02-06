class PayuAdditionalInfo < ApplicationRecord
      
      resourcify
      audited
      belongs_to :payu_response
end
