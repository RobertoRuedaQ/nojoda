class AddBillingDocumentDetailsToBillingDocumentMatch < ActiveRecord::Migration[5.2]
  def change
    remove_reference :billing_document_matches, :billing_document_details, foreign_key: true
    add_reference :billing_document_matches, :billing_document_detail, foreign_key: true
  end
end
