class Modeling < ApplicationRecord
      
  resourcify
  audited
  belongs_to :research_process, optional: true
  has_many :funding_opportunity, dependent: :destroy
  has_many :modeling_fixed_condition, dependent: :destroy
  has_many :custom_disbursements, dependent: :destroy
  has_many :modeling_fee, dependent: :destroy

end
