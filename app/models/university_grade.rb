class UniversityGrade < ApplicationRecord
      
  resourcify
  audited
  has_many_attached :grade_certificate
  belongs_to :student_academic_information
  belongs_to :disbursement, optional: true
  belongs_to :application
  belongs_to :academic_bonus, foreign_key: :academic_bonus_id, class_name: 'Disbursement', optional: true
  has_many :university_course_grade,->{joins(:university_grade).where(["#{UniversityGrade.table_name}.number_of_courses_taken >= course_number"])}, dependent: :destroy
  attribute :grade_certificate
  

  before_update :validate_confirmation

  def validate_confirmation
    PerformServiceAsync.perform_in(15.days, 'ValidateGradesService', self.id)
  end


end
