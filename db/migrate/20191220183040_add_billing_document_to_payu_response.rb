class AddBillingDocumentToPayuResponse < ActiveRecord::Migration[5.2]
  def change
    add_reference :payu_responses, :billing_document, foreign_key: true
  end
end
