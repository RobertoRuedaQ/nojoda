class AddCountryToRateCapUpdate < ActiveRecord::Migration[5.2]
  def change
    add_column :rate_cap_updates, :country, :string
  end
end
