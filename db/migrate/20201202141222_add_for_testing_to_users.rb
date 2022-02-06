class AddForTestingToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :for_testing, :boolean, default: false
  end
end
