class CreateUserQuestionnaireFollowUps < ActiveRecord::Migration[5.2]
  def change
    create_table :user_questionnaire_follow_ups do |t|
      t.references :user_questionnaire, foreign_key: true
      t.string :state
      t.datetime :resolved_at

      t.timestamps
    end
  end
end
