class AddValidationToLegalDocument < ActiveRecord::Migration[5.2]
  def change
    add_column :legal_documents, :validation, :string
  end
end
