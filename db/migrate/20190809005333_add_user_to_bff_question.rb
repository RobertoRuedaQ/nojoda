class AddUserToBffQuestion < ActiveRecord::Migration[5.2]
  def change
    add_reference :bff_questions, :user, foreign_key: true
  end
end
