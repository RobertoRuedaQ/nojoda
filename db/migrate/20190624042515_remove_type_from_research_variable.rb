class RemoveTypeFromResearchVariable < ActiveRecord::Migration[5.2]
  def change
    remove_column :research_variables, :type, :string
  end
end
