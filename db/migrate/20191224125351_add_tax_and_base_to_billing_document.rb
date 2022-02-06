class AddTaxAndBaseToBillingDocument < ActiveRecord::Migration[5.2]
  def change
    add_column :billing_documents, :tax, :float
    add_column :billing_documents, :base, :float
  end
end
