class AddCurrencyToBillingDocumentDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :billing_document_details, :currency, :string
  end
end
