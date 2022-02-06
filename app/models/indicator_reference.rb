class IndicatorReference < ApplicationRecord
  resourcify
  audited
	belongs_to :indicator_case
end
