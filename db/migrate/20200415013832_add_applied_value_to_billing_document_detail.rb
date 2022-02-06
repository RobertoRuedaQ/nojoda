class AddAppliedValueToBillingDocumentDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :billing_document_details, :applied_value, :float
  end
end
