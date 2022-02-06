class AddFirstGenerationHigherEducationToSociodemographic < ActiveRecord::Migration[5.2]
  def change
    add_column :sociodemographics, :first_generation_higher_education, :string
  end
end
