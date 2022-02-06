class AddCurrencyToIncomeInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :income_informations, :currency, :string
  end
end
