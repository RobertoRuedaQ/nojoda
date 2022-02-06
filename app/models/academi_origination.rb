class AcademiOrigination < ApplicationRecord
      
      resourcify
      audited      
  belongs_to :courses,class_name: 'Origination',foreign_key: 'courses_id', optional: true
  belongs_to :partial_scores,class_name: 'Origination',foreign_key: 'partial_scores_id', optional: true
  belongs_to :final_scores,class_name: 'Origination',foreign_key: 'final_scores_id', optional: true
  belongs_to :diploma_delivery,class_name: 'Origination',foreign_key: 'diploma_delivery_id', optional: true
  belongs_to :funding_opportunity

end
