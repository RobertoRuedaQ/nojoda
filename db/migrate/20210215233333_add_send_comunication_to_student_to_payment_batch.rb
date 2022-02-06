class AddSendComunicationToStudentToPaymentBatch < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_batches, :send_comunication_to_student, :boolean, default: true
  end
end
