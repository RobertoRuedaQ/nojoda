class AddValidityToQuestionnaire < ActiveRecord::Migration[5.2]
  def change
    add_column :questionnaires, :validity, :integer
  end
end
