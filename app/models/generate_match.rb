class GenerateMatch < ApplicationRecord
      
      resourcify
      audited
  belongs_to :generate_from_file
  belongs_to :resource
end
