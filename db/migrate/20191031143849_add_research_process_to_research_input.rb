class AddResearchProcessToResearchInput < ActiveRecord::Migration[5.2]
  def change
    add_reference :research_inputs, :research_process, foreign_key: true
  end
end
