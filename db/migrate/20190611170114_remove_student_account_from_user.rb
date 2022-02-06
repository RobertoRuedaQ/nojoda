class RemoveStudentAccountFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :student_account, :boolean
    remove_column :users, :test_account, :boolean
  end
end
