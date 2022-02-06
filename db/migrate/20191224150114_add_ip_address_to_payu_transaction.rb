class AddIpAddressToPayuTransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :payu_transactions, :ip_address, :string
  end
end
