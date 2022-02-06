class ChangeSignioRecordColumnsValues < ActiveRecord::Migration[5.2]
  def change
    change_column :signio_records, :id_transaction, :string, null: true
    change_column :signio_records, :id_contract_document, :string, null: true
    change_column :signio_records, :id_student_in_signio, :string, null: true
  end
end
