class AddReferenceDateToBillingDocument < ActiveRecord::Migration[5.2]
  def change
    add_column :billing_documents, :reference_date, :date
  end
end
