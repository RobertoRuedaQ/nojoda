class AddEquivalencyCoveredToBillingDocumentDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :billing_document_details, :equivalency_covered, :float
  end
end
