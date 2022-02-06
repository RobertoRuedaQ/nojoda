class AddCreateByToBizdevBusiness < ActiveRecord::Migration[5.2]
  def change
    add_reference :bizdev_businesses, :created_by, index: true
  end
end
