class AddVariablesToModelingFixedCondition < ActiveRecord::Migration[5.2]
  def change
    add_column :modeling_fixed_conditions, :nominal_fee, :float
    add_column :modeling_fixed_conditions, :treshold, :float
    add_column :modeling_fixed_conditions, :unemployment_months, :integer
    add_column :modeling_fixed_conditions, :grace_period, :integer
  end
end
