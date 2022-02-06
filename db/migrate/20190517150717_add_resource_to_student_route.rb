class AddResourceToStudentRoute < ActiveRecord::Migration[5.2]
  def change
    add_reference :student_routes, :resource, polymorphic: true, index: true
    remove_column :student_routes, :origination_id
    remove_column :student_routes, :company_id
  end
end
