class AddPresumptiveIncomeToIncomeInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :income_informations, :presumptive_income, :boolean, default: false
  end
end
