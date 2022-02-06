class AddVerbAndActionToResearchProcess < ActiveRecord::Migration[5.2]
  def change
    add_column :research_processes, :verb, :string
    add_column :research_processes, :action, :string
  end
end
