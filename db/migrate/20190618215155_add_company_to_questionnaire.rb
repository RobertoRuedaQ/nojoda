class AddCompanyToQuestionnaire < ActiveRecord::Migration[5.2]
  def change
    add_reference :questionnaires, :company, foreign_key: true
  end
end