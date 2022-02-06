class AddVisibleToStudentToModeling < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :visible_to_student, :boolean
  end
end
