class CreateStudentEmailBatches < ActiveRecord::Migration[5.2]
  def change
    create_table :student_email_batches do |t|
      t.string :email_case
      t.string :status, default: 'active'

      t.timestamps
    end
  end
end
