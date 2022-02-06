class AddTypeOfLaborToIncomeInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :income_informations, :type_of_labor, :string
  end
end
