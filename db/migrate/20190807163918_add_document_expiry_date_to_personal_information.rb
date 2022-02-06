class AddDocumentExpiryDateToPersonalInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :personal_informations, :document_expiry_date, :date
  end
end
