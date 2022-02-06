class ChangeTermInUniversityGrade < ActiveRecord::Migration[5.2]
  def change
  	remove_column :university_grades, :term, :string
  	add_column :university_grades, :term, :integer
    add_column :origination_sections, :description, :text
  end
end
