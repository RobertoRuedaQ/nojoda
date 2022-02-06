class UserQuestionnaireScore < ApplicationRecord
      
      resourcify
      audited
  belongs_to :user_questionnaire
  belongs_to :questionnaire

  def approved?
    self.score.to_f >= self.questionnaire.min_approval_score.to_f ? result = true : result = false
		return result
  end
end
