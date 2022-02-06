class FundingOptionConfig < ApplicationRecord
      
  resourcify
  audited
  belongs_to :funding_option
end
