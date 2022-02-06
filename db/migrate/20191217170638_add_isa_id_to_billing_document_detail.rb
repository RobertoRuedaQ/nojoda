class AddIsaIdToBillingDocumentDetail < ActiveRecord::Migration[5.2]
  def change
    add_reference :billing_document_details, :isa, foreign_key: true
 	add_column :billing_document_details, :detail_case, :string,index: true  
  end
end
