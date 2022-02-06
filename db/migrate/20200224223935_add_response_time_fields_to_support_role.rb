class AddResponseTimeFieldsToSupportRole < ActiveRecord::Migration[5.2]
  def change
    add_column :support_roles, :response_in_days, :integer
    add_column :support_roles, :response_in_hours, :integer
    add_reference :support_roles, :company, foreign_key: true
  end
end
