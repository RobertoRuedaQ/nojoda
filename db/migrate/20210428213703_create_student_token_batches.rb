class CreateStudentTokenBatches < ActiveRecord::Migration[5.2]
  def change
    create_table :student_token_batches do |t|
      t.string :status, default: 'active'
      t.references :funding_opportunity, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
