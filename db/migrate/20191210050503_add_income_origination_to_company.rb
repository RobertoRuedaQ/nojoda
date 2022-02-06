class AddIncomeOriginationToCompany < ActiveRecord::Migration[5.2]
  def change
    add_reference :companies, :income_origination, index: true
    remove_reference :companies, :interview
  end
end
