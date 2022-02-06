class DropCountryFromResearchFilter < ActiveRecord::Migration[5.2]
  def change
    remove_reference :research_filters, :country
    add_reference :research_filters, :country, index: true
  end
end
