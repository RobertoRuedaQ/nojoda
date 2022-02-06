class AddThresholdToModelingFixedCondition < ActiveRecord::Migration[5.2]
  def change
    add_column :modeling_fixed_conditions, :threshold, :float
    remove_column :modeling_fixed_conditions, :treshold, :float
  end
end
