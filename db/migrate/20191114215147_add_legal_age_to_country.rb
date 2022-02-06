class AddLegalAgeToCountry < ActiveRecord::Migration[5.2]
  def change
    add_column :countries, :legal_age, :integer
  end
end
