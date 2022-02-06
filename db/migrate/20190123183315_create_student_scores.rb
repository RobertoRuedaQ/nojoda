class CreateStudentScores < ActiveRecord::Migration[5.2]
  def change
    create_table :student_scores do |t|
      t.references :questionnaire, foreign_key: true
      t.float :score


      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      


      t.timestamps
    end
  end
end
