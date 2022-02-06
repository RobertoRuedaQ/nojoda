class AddConfirmedToUserQuestionnaire < ActiveRecord::Migration[5.2]
  def change
    add_column :user_questionnaires, :confirmed, :boolean
  end
end
