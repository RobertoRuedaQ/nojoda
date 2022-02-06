class ModelingFixedCondition < ApplicationRecord
      
  resourcify
  audited
  belongs_to :modeling
  has_many :modeling_match, as: :resource , dependent: :destroy
  has_many :funding_option
end
