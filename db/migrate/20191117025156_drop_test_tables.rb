class DropTestTables < ActiveRecord::Migration[5.2]
  def change
  	drop_table :some_tests, if_exists: true
  	drop_table :another_tests, if_exists: true
  	drop_table :inv_committees, if_exists: true
  end
end
