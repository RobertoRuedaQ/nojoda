class AddModelStatusToFundingOption < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_options, :model_status, :string
  end
end
