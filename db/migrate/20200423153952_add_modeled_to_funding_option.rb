class AddModeledToFundingOption < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_options, :modeled, :boolean
  end
end
