class Condonation < ApplicationRecord
      
      resourcify
      audited
  belongs_to :disbursement
	belongs_to :resource, polymorphic: true
end
