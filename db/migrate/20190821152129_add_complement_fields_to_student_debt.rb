class AddComplementFieldsToStudentDebt < ActiveRecord::Migration[5.2]
  def change
    add_column :student_debts, :monthly_payment, :float
  end
end
