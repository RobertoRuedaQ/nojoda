class AddFirstContactDateToBizdevBusiness < ActiveRecord::Migration[5.2]
  def change
    add_column :bizdev_businesses, :first_conctact_date, :date
  end
end
