class AddInternalCodeToInstitution < ActiveRecord::Migration[5.2]
  def change
    add_column :institutions, :internal_code, :string
  end
end
