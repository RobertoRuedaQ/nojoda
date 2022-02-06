class AddCapRateToFund < ActiveRecord::Migration[5.2]
  def change
    add_column :funds, :cap_rate, :float
  end
end
