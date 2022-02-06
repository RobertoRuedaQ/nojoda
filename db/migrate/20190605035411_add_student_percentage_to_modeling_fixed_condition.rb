class AddStudentPercentageToModelingFixedCondition < ActiveRecord::Migration[5.2]
  def change
    add_column :modeling_fixed_conditions, :student_percentage, :float
  end
end
