class AddValueToCapWithExcessToFundingOption < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_options, :value_to_cap_with_excess, :float
  end
end
