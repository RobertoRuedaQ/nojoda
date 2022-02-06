class AddPartialScoreToUniversityCourseGrade < ActiveRecord::Migration[5.2]
  def change
    add_column :university_course_grades, :partial_score, :string
  end
end
