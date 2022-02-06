class AddOtherValueToFundingOptionConfig < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_option_configs, :other_value, :string
  end
end
