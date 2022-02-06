class ProcessOrigination < ApplicationRecord
      
      resourcify
      audited
  belongs_to :bank_account,class_name: 'Origination',foreign_key: 'bank_accountn_id', optional: true
  belongs_to :identification_document,class_name: 'Origination',foreign_key: 'identification_document_id', optional: true
  belongs_to :funding_opportunity
  belongs_to :mentory_empleability_invitation, class_name:'Origination', foreign_key: 'mentory_empleability_invitation_origination_id', optional: true
  


  def origination
  	result = self.academic_origination.send(self.request_case)
  	if result.nil?
  		result.student_academic_information.origination
  	end
  	return result
  end

  
end
