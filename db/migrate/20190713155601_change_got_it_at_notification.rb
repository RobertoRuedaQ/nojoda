class ChangeGotItAtNotification < ActiveRecord::Migration[5.2]
  def change
  	change_column :notifications, :got_it, :boolean, default: false, null: false
  end
end
