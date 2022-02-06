class AddCreatorIdToUserQuestionnaireFollowUp < ActiveRecord::Migration[5.2]
  def change
    add_column :user_questionnaire_follow_ups, :creator_id, :integer
  end
end
