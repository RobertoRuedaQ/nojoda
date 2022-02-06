class AddSocialToSociodemographic < ActiveRecord::Migration[5.2]
  def change
    add_column :sociodemographics, :social_program_check, :boolean
    add_column :sociodemographics, :social_program_text, :string
    add_column :sociodemographics, :social_program_other, :string
  end
end
