class AddWhatsappToContactInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :contact_infos, :whatsapp, :string
  end
end
