class PaymentExcess < ApplicationRecord
      
      resourcify
      audited
  belongs_to :user
  belongs_to :payment

  validates :value, numericality: { greater_than: 0 }
end
