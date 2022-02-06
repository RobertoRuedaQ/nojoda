class AddActivationCheckToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :activation_check, :boolean
  end
end
