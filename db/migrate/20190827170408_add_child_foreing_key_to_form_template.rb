class AddChildForeingKeyToFormTemplate < ActiveRecord::Migration[5.2]
  def change
    add_column :form_templates, :child_foreign_key, :string
  end
end
