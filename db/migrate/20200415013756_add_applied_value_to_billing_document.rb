class AddAppliedValueToBillingDocument < ActiveRecord::Migration[5.2]
  def change
    add_column :billing_documents, :applied_value, :float
  end
end
