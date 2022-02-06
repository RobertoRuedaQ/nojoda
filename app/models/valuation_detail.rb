class ValuationDetail < ApplicationRecord
      
      resourcify
      audited
  belongs_to :valuation_history
end
