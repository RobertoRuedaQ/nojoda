class AddCommentToIsaStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :isa_statuses, :comment, :string, default: ''
  end
end
