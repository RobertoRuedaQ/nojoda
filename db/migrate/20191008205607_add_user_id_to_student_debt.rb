class AddUserIdToStudentDebt < ActiveRecord::Migration[5.2]
  def change
    add_reference :student_debts, :user, foreign_key: true
  end
end
