class AddCourpToPersonalInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :personal_informations, :curp_id, :string
    add_column :personal_informations, :curp_document, :string
    add_column :personal_informations, :nationality, :string
    add_column :references, :curp_id, :string
    add_column :references, :curp_document, :string
    add_column :references, :nationality, :string
  end
end
