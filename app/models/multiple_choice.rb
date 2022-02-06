class MultipleChoice < ApplicationRecord
      
      resourcify
      audited
	belongs_to :resource, polymorphic: true
end
