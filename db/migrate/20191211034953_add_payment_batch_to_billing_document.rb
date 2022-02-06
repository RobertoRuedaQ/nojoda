class AddPaymentBatchToBillingDocument < ActiveRecord::Migration[5.2]
  def change
    add_reference :billing_documents, :payment_batch, foreign_key: true
  end
end
