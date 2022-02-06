class AddActiveToIsaStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :isa_statuses, :active, :boolean
  end
end
