class AddTaxIdentificationNumberToInstitution < ActiveRecord::Migration[5.2]
  def change
    add_column :institutions, :tax_identification_number, :string
  end
end
