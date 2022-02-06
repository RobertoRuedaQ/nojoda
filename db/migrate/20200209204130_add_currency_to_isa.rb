class AddCurrencyToIsa < ActiveRecord::Migration[5.2]
  def change
    add_column :isas, :currency, :string
  end
end
