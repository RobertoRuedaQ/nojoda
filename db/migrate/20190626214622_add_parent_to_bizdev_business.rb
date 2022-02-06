class AddParentToBizdevBusiness < ActiveRecord::Migration[5.2]
  def change
    add_reference :bizdev_businesses, :bizdev_business, foreign_key: true
  end
end
