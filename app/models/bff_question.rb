class BffQuestion < ApplicationRecord
      
      resourcify
      audited
      belongs_to :user
end
