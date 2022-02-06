class AddEmploymentStatusCommentToIsa < ActiveRecord::Migration[5.2]
  def change
    add_column :isas, :employment_status_comment, :string, default: ''
  end
end
