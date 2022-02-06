class ApplicationComponent < ApplicationRecord
  resourcify
  audited
	belongs_to :funding_opportunity
	belongs_to :reference
end
