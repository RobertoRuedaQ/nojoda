class AddNotesToUserQuestionnaireAnswer < ActiveRecord::Migration[5.2]
  def change
    add_column :user_questionnaire_answers, :notes, :text
  end
end
