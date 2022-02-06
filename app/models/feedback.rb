class Feedback < ApplicationRecord
      
      resourcify
      audited
  belongs_to :autor, class_name: 'User', foreign_key: 'autor_id'
end
