class RemoveForcastedValueFromDisbursement < ActiveRecord::Migration[5.2]
  def change
    remove_column :disbursements, :forcasted_value, :float
  end
end
