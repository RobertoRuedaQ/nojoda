class CreateObjectOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :object_orders do |t|
      t.integer :level
      t.references :superior, polymorphic: true, index:true
      t.references :subordinate, polymorphic: true, index:true

      t.timestamps
    end
  end
end
