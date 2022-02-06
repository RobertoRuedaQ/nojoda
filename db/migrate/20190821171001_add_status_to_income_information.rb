class AddStatusToIncomeInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :income_informations, :status, :string
    add_column :income_informations, :active, :boolean
  end
end
