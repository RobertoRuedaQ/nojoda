class AddGenderToReference < ActiveRecord::Migration[5.2]
  def change
    add_column :references, :gender, :string
    add_column :references, :validation_status, :string
    add_column :references, :notes, :text
    add_column :references, :guardian_check, :boolean
  end
end
