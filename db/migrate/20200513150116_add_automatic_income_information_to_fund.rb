class AddAutomaticIncomeInformationToFund < ActiveRecord::Migration[5.2]
  def change
    add_column :funds, :automatic_variable_income, :boolean
  end
end
