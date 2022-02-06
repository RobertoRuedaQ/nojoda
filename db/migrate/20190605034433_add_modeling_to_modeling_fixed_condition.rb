class AddModelingToModelingFixedCondition < ActiveRecord::Migration[5.2]
  def change
    add_reference :modeling_fixed_conditions, :modeling, foreign_key: true
  end
end
