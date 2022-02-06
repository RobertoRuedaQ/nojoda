class ObjectOrder < ApplicationRecord
  resourcify
  audited
	belongs_to :superior, polymorphic: true
	belongs_to :subordinate, polymorphic: true
	belongs_to :subordinated_questions,->{joins(:subordinated).where(object_orders: {subordinate_type: 'Question'})},class_name: 'Question',foreign_key: 'subordinate_id',optional: true

end
