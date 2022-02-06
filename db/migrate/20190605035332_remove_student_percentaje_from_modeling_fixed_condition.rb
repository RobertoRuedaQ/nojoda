class RemoveStudentPercentajeFromModelingFixedCondition < ActiveRecord::Migration[5.2]
  def change
    remove_column :modeling_fixed_conditions, :student_percentaje, :float
  end
end
