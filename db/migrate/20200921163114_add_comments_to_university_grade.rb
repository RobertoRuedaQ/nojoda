class AddCommentsToUniversityGrade < ActiveRecord::Migration[5.2]
  def change
    add_column :university_grades, :comments, :text
  end
end
