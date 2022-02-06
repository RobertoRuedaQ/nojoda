class AddApplicationToUserQuestionnaire < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_questionnaires, :application, foreign_key: true
  end
end
