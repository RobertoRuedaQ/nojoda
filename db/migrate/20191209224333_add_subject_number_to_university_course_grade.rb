class AddSubjectNumberToUniversityCourseGrade < ActiveRecord::Migration[5.2]
  def change
    add_column :university_course_grades, :course_number, :integer
  end
end
