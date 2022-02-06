class AddBillingDocumentToIncomeVariableIncome < ActiveRecord::Migration[5.2]
  def change
    add_reference :income_variable_incomes, :billing_document, foreign_key: true
  end
end
