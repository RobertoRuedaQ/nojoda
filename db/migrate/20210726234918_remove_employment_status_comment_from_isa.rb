class RemoveEmploymentStatusCommentFromIsa < ActiveRecord::Migration[5.2]
  def change
    remove_column :isas, :employment_status_comment
    add_reference :isas, :employment_status_collection_trigger, foreign_key: { to_table: :collections }, index: true
  end
end
