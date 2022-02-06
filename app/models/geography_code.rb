class GeographyCode < ApplicationRecord
      
      resourcify
      audited
  belongs_to :geography
end
