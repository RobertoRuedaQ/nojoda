class ValidateGradesService

  def self.for(university_grade_id)
    new(university_grade_id).perform
  end

  def initialize(university_grade_id)
    @university_grade = UniversityGrade.find(university_grade_id)
  end


  def perform
    collection = @university_grade.university_course_grade.pluck(:done)
    if collection.any? && collection.all?(true)
      @university_grade.update_column('confirmed', true)
      @university_grade.student_academic_information.update(current_term: @university_grade.term)
    else
      PerformServiceAsync.perform_in(1.day, 'ValidateGradesService', @university_grade.id)
    end
  end

end