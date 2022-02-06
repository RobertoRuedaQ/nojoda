class AddUsersToBlackRockDatas < ActiveRecord::Migration[5.2]
  def change
    add_reference :black_rock_data, :user, foreign_key: true
  end
end
