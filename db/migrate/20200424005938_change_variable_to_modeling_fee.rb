class ChangeVariableToModelingFee < ActiveRecord::Migration[5.2]
  def change
  	change_column :modeling_fees, :value_fee_start_fee_field, :string
  	change_column :modeling_fees, :value_fee_end_fee_field, :string
  	change_column :modeling_fees, :value_fee_unique_date_field, :string
  end
end
