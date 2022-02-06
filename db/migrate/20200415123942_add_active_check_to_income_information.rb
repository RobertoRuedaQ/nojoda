class AddActiveCheckToIncomeInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :income_informations, :active_check, :boolean
  end
end
