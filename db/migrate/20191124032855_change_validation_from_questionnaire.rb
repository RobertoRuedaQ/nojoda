class ChangeValidationFromQuestionnaire < ActiveRecord::Migration[5.2]
  def change
	change_column :questionnaires, :validity, :string
  end
end
