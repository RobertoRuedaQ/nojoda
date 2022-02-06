class AddPaymentAgreeementToBillingDocumentDetail < ActiveRecord::Migration[5.2]
  def change
    add_reference :billing_document_details, :payment_agreement, foreign_key: true
  end
end
