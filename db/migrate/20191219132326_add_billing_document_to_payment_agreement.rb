class AddBillingDocumentToPaymentAgreement < ActiveRecord::Migration[5.2]
  def change
    add_reference :payment_agreements, :billing_document, foreign_key: true
  end
end
