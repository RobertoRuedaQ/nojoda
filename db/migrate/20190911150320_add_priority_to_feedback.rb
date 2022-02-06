class AddPriorityToFeedback < ActiveRecord::Migration[5.2]
  def change
    add_column :feedbacks, :priority, :string
    add_column :feedbacks, :expected_impact, :string
    add_column :feedbacks, :dificulty, :string
    add_column :feedbacks, :category, :string
  end
end
