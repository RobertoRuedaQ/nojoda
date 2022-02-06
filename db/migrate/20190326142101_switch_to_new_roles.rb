class SwitchToNewRoles < ActiveRecord::Migration[5.2]
  def change
  	remove_reference :users, :supervisor
  	drop_table :roles, if_exists: true
  	drop_table :users_roles, if_exists: true
  end
end
