class AddMinValueToModelingFee < ActiveRecord::Migration[5.2]
  def change
    add_column :modeling_fees, :min_value, :float
  end
end
