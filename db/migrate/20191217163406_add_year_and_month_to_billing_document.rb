class AddYearAndMonthToBillingDocument < ActiveRecord::Migration[5.2]
  def change
    add_column :billing_documents, :year, :integer
    add_column :billing_documents, :month, :integer
  end
end
