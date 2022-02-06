class AddContactEmailToContactInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :contact_infos, :contact_email, :string
  end
end
