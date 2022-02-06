class RemoveModeledToFundingOption < ActiveRecord::Migration[5.2]
  def change
  	remove_column :funding_options, :modeled, :boolean
  end
end
