class AddActiveToResearchModelInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :research_model_infos, :active, :boolean, default: true
  end
end
