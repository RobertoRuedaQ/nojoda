class QuestionnaireException < ApplicationRecord
      
      resourcify
      audited
  belongs_to :user_questionnaire
end
