class AcademicRequest < ApplicationRecord
      
      resourcify
      audited
  belongs_to :student_academic_information
	has_one :application,->{kept},class_name: 'Application', as: :resource , dependent: :destroy


  def academic_origination
  	self.student_academic_information.user.funding_opportunities.first.academi_origination
  end


  def origination
  	result = self.academic_origination.send(self.request_case)
  	if result.nil?
  		result.student_academic_information.origination
  	end
  	return result
  end
end
