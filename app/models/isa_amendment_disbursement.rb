class IsaAmendmentDisbursement < ApplicationRecord
      
      resourcify
      audited
  belongs_to :isa_amendment
  belongs_to :disbursement, optional: true




end
