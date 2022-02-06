class AddIndexCategoryToQuestionnaire < ActiveRecord::Migration[5.2]
  def change
  	add_index :questionnaires, :category
  end
end
