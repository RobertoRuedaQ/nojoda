class RenameAverageInUniversityCourseGrade < ActiveRecord::Migration[5.2]
  def change
    rename_column :university_course_grades, :average, :final_score
  end
end
