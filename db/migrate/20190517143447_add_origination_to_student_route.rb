class AddOriginationToStudentRoute < ActiveRecord::Migration[5.2]
  def change
    add_reference :student_routes, :origination, foreign_key: true
  end
end
