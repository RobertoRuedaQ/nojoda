class AddProtectedToSignioRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :signio_records, :promissory_document_protected, :boolean, default: false
    add_column :signio_records, :contract_document_protected, :boolean, default: false
  end
end
