class AddSubjectsAndCreditsToUniversityGrade < ActiveRecord::Migration[5.2]
  def change
    add_column :university_grades, :number_of_courses_taken, :integer
    add_column :university_grades, :number_of_courses_failed, :integer
    add_column :university_grades, :number_of_credits, :integer
  end
end
