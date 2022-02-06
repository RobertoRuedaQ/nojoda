class CancellationConfig < ApplicationRecord
      
      resourcify
      audited
  belongs_to :fund, touch: true
end
