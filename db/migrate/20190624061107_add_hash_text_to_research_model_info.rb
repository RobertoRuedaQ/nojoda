class AddHashTextToResearchModelInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :research_model_infos, :hash_text, :string
  end
end
