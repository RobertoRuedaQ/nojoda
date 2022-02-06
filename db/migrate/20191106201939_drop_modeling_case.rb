class DropModelingCase < ActiveRecord::Migration[5.2]
  def change
    #remove_reference :modelings, :modeling_case, foreign_key: true

  	drop_table :modeling_cases, if_exists: true
  end
end
