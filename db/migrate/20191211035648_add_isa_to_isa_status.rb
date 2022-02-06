class AddIsaToIsaStatus < ActiveRecord::Migration[5.2]
  def change
    add_reference :isa_statuses, :isa, foreign_key: true
  end
end
