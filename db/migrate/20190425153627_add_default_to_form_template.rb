class AddDefaultToFormTemplate < ActiveRecord::Migration[5.2]
  def change
    add_column :form_templates, :default, :boolean
    add_index :form_templates, :default
  end
end
