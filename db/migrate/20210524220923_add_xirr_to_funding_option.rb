class AddXirrToFundingOption < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_options, :xirr, :float
  end
end
