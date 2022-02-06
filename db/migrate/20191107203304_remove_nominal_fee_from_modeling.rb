class RemoveNominalFeeFromModeling < ActiveRecord::Migration[5.2]
  def change
    remove_column :modeling_fixed_conditions, :nominal_fee, :float
  end
end
