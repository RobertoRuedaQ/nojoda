class PrincingTable < ApplicationRecord
  resourcify
  audited

  belongs_to :institution
  belongs_to :funding_opportunity
  has_many :pricing_detail
end
