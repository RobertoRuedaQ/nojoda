class RemoveHashFromResearchModelInfo < ActiveRecord::Migration[5.2]
  def change
    remove_column :research_model_infos, :hash, :string
  end
end
