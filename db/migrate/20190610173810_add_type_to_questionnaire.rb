class AddTypeToQuestionnaire < ActiveRecord::Migration[5.2]
  def change
    add_column :questionnaires, :type_of_quesitonnaire, :string
  end
end
