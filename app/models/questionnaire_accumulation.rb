class QuestionnaireAccumulation < ApplicationRecord
      
      resourcify
      audited
  belongs_to :questionnaire
end
