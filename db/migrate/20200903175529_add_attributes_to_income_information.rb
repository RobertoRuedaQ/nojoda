class AddAttributesToIncomeInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :income_informations, :tier, :string
    add_column :income_informations, :area, :string
    add_column :income_informations, :related_with_studies, :boolean, default: false
  end
end
