class CheckMode < ApplicationRecord
      
      resourcify
      audited
  belongs_to :check_field
end
