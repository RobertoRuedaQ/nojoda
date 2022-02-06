class GenerateFromFile < ApplicationRecord
      
      resourcify
      audited
  belongs_to :resource
end
