class AddVisibleInQuestionnairesToOriginationSection < ActiveRecord::Migration[5.2]
  def change
    add_column :origination_sections, :visible_in_review_questionnaire, :boolean
  end
end
