class ChangeCountryFromResearchFilter < ActiveRecord::Migration[5.2]
  def change
  	change_column :research_filters, :country_id, :integer
  end
end
