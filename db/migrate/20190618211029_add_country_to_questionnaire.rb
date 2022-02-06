class AddCountryToQuestionnaire < ActiveRecord::Migration[5.2]
  def change
    add_reference :questionnaires, :country, foreign_key: true
  end
end
