class BatchDetail < ApplicationRecord
      
      resourcify
      audited
  belongs_to :isa
  belongs_to :payment_batch
end
