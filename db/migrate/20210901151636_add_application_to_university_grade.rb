class AddApplicationToUniversityGrade < ActiveRecord::Migration[5.2]
  def change
    add_reference :university_grades, :application, foreign_key: true
  end
end
