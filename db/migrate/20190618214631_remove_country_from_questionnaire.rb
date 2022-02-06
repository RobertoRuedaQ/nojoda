class RemoveCountryFromQuestionnaire < ActiveRecord::Migration[5.2]
  def change
    remove_reference :questionnaires, :country, foreign_key: true
  end
end
