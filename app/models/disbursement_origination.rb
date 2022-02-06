class DisbursementOrigination < ApplicationRecord
      
      resourcify
      audited
  belongs_to :funding_opportunity,touch: true
  belongs_to :origination_tuition,class_name: 'Origination',foreign_key: 'origination_id', optional: true
  belongs_to :origination_living_expenses,class_name: 'Origination',foreign_key: 'origin_living_id', optional: true
  belongs_to :origination_bonus,class_name: 'Origination',foreign_key: 'bonus_origination_id', optional: true
  belongs_to :origination_emergency,class_name: 'Origination',foreign_key: 'emergency_living_expenses_origination_id', optional: true
  belongs_to :review_tuition, class_name: 'Questionnaire',foreign_key: 'review_tuition_id', optional: true
  belongs_to :review_living, class_name: 'Questionnaire',foreign_key: 'review_living_id', optional: true
end
