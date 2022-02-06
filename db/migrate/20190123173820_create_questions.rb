class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :question
      t.integer :position
      t.string :category
      t.float :max_score, default: 100
      t.references :questionnaire, foreign_key: true
      t.float :weight, default: 100
      t.integer :position

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      

      t.timestamps
    end
  end
end
