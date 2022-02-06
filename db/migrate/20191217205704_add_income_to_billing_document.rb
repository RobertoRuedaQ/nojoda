class AddIncomeToBillingDocument < ActiveRecord::Migration[5.2]
  def change
    add_column :billing_documents, :income_value, :float
    add_column :billing_documents, :income_case, :string
  end
end
