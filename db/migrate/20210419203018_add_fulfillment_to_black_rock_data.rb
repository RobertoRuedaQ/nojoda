class AddFulfillmentToBlackRockData < ActiveRecord::Migration[5.2]
  def change
    add_column :black_rock_data, :fulfillment, :text
  end
end
