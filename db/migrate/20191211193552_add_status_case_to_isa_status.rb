class AddStatusCaseToIsaStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :isa_statuses, :status_case, :string
  end
end
