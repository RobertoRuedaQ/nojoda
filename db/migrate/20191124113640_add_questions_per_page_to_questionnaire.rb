class AddQuestionsPerPageToQuestionnaire < ActiveRecord::Migration[5.2]
  def change
    add_column :questionnaires, :questions_per_page, :integer
  end
end
