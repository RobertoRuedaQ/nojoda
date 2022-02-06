class AddPeriodToUniversityGrade < ActiveRecord::Migration[5.2]
  def change
    add_column :university_grades, :period, :string
  end
end
