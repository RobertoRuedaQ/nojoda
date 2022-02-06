class DropStudentTestTable < ActiveRecord::Migration[5.2]
  def change
  	drop_table :student_tests, if_exists: true
  end
end
