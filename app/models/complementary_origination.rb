class ComplementaryOrigination < ApplicationRecord
      
      resourcify
      audited
  belongs_to :funding_opportunity
  belongs_to :diploma_delivery,class_name: 'Origination',foreign_key: 'diploma_delivery_id', optional: true
  belongs_to :identification_document,class_name: 'Origination',foreign_key: 'identification_document_id', optional: true
  belongs_to :grades,class_name: 'Origination',foreign_key: 'grades_id', optional: true
  belongs_to :academic_stop,class_name: 'Origination',foreign_key: 'academic_stop_id', optional: true
  belongs_to :financial_adjust,class_name: 'Origination',foreign_key: 'inancial_adjust_id', optional: true
  belongs_to :conciliation,class_name: 'Origination',foreign_key: 'conciliation_id', optional: true



end
