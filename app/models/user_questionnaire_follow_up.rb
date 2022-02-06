class UserQuestionnaireFollowUp < ApplicationRecord
  belongs_to :user_questionnaire
  belongs_to :creator, :class_name => 'User'

  validates :creator_id, :user_questionnaire_id, :state, :resolved_at, presence: true
end
