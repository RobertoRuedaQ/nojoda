class PricingDetail < ApplicationRecord
  resourcify
  audited

  belongs_to :pricing_table
  has_many :pricing_serie
end
