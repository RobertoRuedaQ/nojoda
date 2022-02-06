class AddNameToQuestionnaireAccumulation < ActiveRecord::Migration[5.2]
  def change
    add_column :questionnaire_accumulations, :name, :string
  end
end
