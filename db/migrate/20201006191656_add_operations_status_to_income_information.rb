class AddOperationsStatusToIncomeInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :income_informations, :operations_status, :string
  end
end
