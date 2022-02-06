class AddDoneToUniversityCourseGrade < ActiveRecord::Migration[5.2]
  def change
    add_column :university_course_grades, :done, :boolean, default: false
  end
end
