class AddUserToInfoTerpel < ActiveRecord::Migration[5.2]
  def change
    add_reference :info_terpels, :user, foreign_key: true
  end
end
