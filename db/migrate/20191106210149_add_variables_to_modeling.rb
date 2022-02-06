class AddVariablesToModeling < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :modeling_case, :string
    add_column :modelings, :max_percentage_study, :float
    add_column :modelings, :max_percentage_graduated, :float
  end
end
