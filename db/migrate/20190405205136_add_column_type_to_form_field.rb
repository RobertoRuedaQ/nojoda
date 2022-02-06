class AddColumnTypeToFormField < ActiveRecord::Migration[5.2]
  def change
    add_column :form_fields, :format, :string
  end
end
