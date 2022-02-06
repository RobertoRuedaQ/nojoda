class ChangeVariablePartFromModelingFee < ActiveRecord::Migration[5.2]
  def change
  	change_column :modeling_fees, :value_fee_variable_part_field, :string
  end
end
