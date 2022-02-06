class RemoveCapFromFundingOption < ActiveRecord::Migration[5.2]
  def change
    remove_column :funding_options, :cap_case, :string
    remove_column :funding_options, :cap_value, :float
  end
end
