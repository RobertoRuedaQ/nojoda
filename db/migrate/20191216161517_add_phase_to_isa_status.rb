class AddPhaseToIsaStatus < ActiveRecord::Migration[5.2]
  def change
  	remove_column :isa_statuses, :active, :boolean
    add_column :isa_statuses, :phase, :string
  end
end
