class AddReferenceDateToBillingDocumentDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :billing_document_details, :reference_date, :date
  end
end
