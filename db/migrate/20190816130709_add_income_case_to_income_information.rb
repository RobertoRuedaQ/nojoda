class AddIncomeCaseToIncomeInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :income_informations, :income_case, :string
  end
end
