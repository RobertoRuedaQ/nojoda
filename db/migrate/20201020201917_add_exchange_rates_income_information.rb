class AddExchangeRatesIncomeInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :income_informations, :exchange_rates, :decimal, default: 1
  end
end
