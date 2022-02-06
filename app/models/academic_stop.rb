class AcademicStop < ApplicationRecord
      
      resourcify
      audited
  belongs_to :student_academic_information,touch: true
  has_many_attached :academic_stop_support

  def origination
    self.student_academic_information.funding_opportunity.fund.academic_stop_origination
  end
end
