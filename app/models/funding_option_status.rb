class FundingOptionStatus < ApplicationRecord
      
      resourcify
      audited
  belongs_to :funding_option_config
end
