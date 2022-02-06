class PricingSerie < ApplicationRecord
  resourcify
  audited

  belongs_to :pricing_detail
end
