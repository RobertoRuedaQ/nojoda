class AddSearcherNameToInstitution < ActiveRecord::Migration[5.2]
  def change
    add_column :institutions, :searcher_name, :string
  end
end
