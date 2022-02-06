class AddExplanationToAcademicStop < ActiveRecord::Migration[5.2]
  def change
    add_column :academic_stops, :explanation, :text
  end
end
