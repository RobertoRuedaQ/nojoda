class ChangeConfictInvolvementInSociodemographic < ActiveRecord::Migration[5.2]
  def change
  	change_column :sociodemographics, :confict_involvement, :string
  end
end
