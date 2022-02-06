class AddCurrencyToBizdevBusiness < ActiveRecord::Migration[5.2]
  def change
    add_column :bizdev_businesses, :currency, :string
  end
end
