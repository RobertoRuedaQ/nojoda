class AddConfirmedToUniversityGrade < ActiveRecord::Migration[5.2]
  def change
    add_column :university_grades, :confirmed, :boolean, default: false
  end
end
