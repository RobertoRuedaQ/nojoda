class AddExpirationDateToUserQuestionnaire < ActiveRecord::Migration[5.2]
  def change
    add_column :user_questionnaires, :expiration_date, :date
  end
end
