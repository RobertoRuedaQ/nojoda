class AddResearchProcessToModeling < ActiveRecord::Migration[5.2]
  def change
    add_reference :modelings, :research_process, foreign_key: true
  end
end
