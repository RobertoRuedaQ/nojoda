class CreateStudentAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :student_answers do |t|
      t.references :student_score, foreign_key: true
      t.references :answers, foreign_key: true


      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      


      t.timestamps
    end
  end
end
