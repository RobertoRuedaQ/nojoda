class AddTargetToFundingOption < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_options, :target, :string
    add_column :funding_options, :target_value, :float
    add_column :funding_options, :cap_case, :string
    add_column :funding_options, :cap_value, :float
  end
end
