class AddSearcherNameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :searcher_name, :string
  end
end
