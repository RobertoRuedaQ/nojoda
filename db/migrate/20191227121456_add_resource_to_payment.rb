class AddResourceToPayment < ActiveRecord::Migration[5.2]
  def change
    add_reference :payments, :resource, polymorphic: true, index: true
  end
end
