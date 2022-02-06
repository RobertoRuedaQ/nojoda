class AddTypeOfVariableToResearchVariable < ActiveRecord::Migration[5.2]
  def change
    add_column :research_variables, :type_of_variable, :string
  end
end
