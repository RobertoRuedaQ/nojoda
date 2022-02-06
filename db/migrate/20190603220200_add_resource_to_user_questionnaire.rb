class AddResourceToUserQuestionnaire < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_questionnaires, :resource, polymorphic: true, index: true
  end
end
