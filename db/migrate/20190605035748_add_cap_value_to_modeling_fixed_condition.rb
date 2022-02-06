class AddCapValueToModelingFixedCondition < ActiveRecord::Migration[5.2]
  def change
    add_column :modeling_fixed_conditions, :cap_value, :float
  end
end
