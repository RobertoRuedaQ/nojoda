class PaymentOrigination < ApplicationRecord
      
      resourcify
      audited
  belongs_to :manual_payment_origination,class_name: 'Origination',foreign_key: 'manual_payment_origination_id', optional: true

  belongs_to :company, optional: true
  belongs_to :fund
end
