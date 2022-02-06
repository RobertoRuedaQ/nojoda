class AddColumnsToSignioRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :signio_records, :add_signature_coordinates_student_response, :string
    add_column :signio_records, :add_signature_coordinates_legal_representative_response, :string
    add_column :signio_records, :add_signature_coordinates_jointly_liable_response, :string
    add_column :signio_records, :add_signature_coordinates_zigma_representative_response, :string
    add_column :signio_records, :send_to_sign_response, :string
    add_column :signio_records, :comments, :string
  end
end
