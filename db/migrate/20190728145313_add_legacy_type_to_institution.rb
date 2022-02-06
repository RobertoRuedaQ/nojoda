class AddLegacyTypeToInstitution < ActiveRecord::Migration[5.2]
  def change
    add_column :institutions, :legacy_type, :string
  end
end
