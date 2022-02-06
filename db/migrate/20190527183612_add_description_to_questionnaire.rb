class AddDescriptionToQuestionnaire < ActiveRecord::Migration[5.2]
  def change
    add_column :questionnaires, :instructions, :text
  end
end
