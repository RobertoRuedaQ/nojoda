class AddColumsToSociodemographic < ActiveRecord::Migration[5.2]
  def change
    add_column :sociodemographics, :hobbies_or_voluntary_description, :text
    add_column :sociodemographics, :community_development_description, :text
    add_column :sociodemographics, :leadership_description, :text
    add_column :sociodemographics, :gen_fifty_how_know_about_benefit, :string
  end
end
