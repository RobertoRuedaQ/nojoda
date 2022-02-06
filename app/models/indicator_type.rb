class IndicatorType < ApplicationRecord
  resourcify
  audited
  has_many :indicator_case, dependent: :destroy

end
