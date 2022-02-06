class AddTargetToPaymentMatch < ActiveRecord::Migration[5.2]
  def change
    add_reference :payment_matches, :target_record, polymorphic: true, index: false
    remove_reference :payment_matches, :billing_document_detail
  end
end
