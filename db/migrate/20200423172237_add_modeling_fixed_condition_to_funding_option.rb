class AddModelingFixedConditionToFundingOption < ActiveRecord::Migration[5.2]
  def change
    add_reference :funding_options, :modeling_fixed_condition, foreign_key: true
  end
end
