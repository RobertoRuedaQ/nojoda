class RemoveEmailFromContactInfo < ActiveRecord::Migration[5.2]
  def change
    remove_column :contact_infos, :email, :string
  end
end
