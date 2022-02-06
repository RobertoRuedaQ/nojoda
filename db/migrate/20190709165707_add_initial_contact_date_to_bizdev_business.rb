class AddInitialContactDateToBizdevBusiness < ActiveRecord::Migration[5.2]
  def change
    add_column :bizdev_businesses, :initial_contact_date, :date
  end
end
