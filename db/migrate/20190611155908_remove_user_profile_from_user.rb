class RemoveUserProfileFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_reference :users, :user_profile, polymorphic: true
  end
end
