class AddGeneralStatusToBizdevBusiness < ActiveRecord::Migration[5.2]
  def change
    add_column :bizdev_businesses, :general_status, :string
  end
end
