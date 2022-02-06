class AddVariableGracePeriodToFund < ActiveRecord::Migration[5.2]
  def change
    add_column :funds, :variable_grace_period, :boolean
    add_column :funds, :forcasted_salary_clause, :boolean
  end
end
