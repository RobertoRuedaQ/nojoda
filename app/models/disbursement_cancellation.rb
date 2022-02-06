class DisbursementCancellation < ApplicationRecord
      
      resourcify
      audited
  belongs_to :disbursement, touch: true
  belongs_to :cancellation_config
  validates_uniqueness_of :disbursement_id, scope: :cancellation_config_id



	def cancellation_percentage
		(self.value.to_f / self.disbursement.adjusted_student_value.to_f) * 100
	end  
end
