class UserQuestionnaireAnswer < ApplicationRecord
      
      resourcify
      audited
  belongs_to :answer
  belongs_to :user_questionnaire, touch: true
end
