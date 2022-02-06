class AddActiveToBillingDocument < ActiveRecord::Migration[5.2]
  def change
    add_column :billing_documents, :active, :boolean
  end
end
