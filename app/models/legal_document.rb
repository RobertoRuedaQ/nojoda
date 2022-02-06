class LegalDocument < ApplicationRecord
  resourcify
  audited

  has_many_attached :images
  belongs_to :company
  belongs_to :legal_document, optional: true
  has_many :legal_document
  has_many :eligibility_criteria, :class_name => 'LegalDocument', foreign_key: 'eligibility_criteria_id'
  has_many :origination_section, as: :resource
  
end
