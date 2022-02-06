class AddEntityToStudentDebt < ActiveRecord::Migration[5.2]
  def change
    add_column :student_debts, :entity, :string
  end
end
