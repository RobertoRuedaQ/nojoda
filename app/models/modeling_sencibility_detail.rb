class ModelingSencibilityDetail < ApplicationRecord
      
      resourcify
      audited
  belongs_to :modeling_sencibility
  belongs_to :funding_option
end
