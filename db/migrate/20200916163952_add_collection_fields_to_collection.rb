class AddCollectionFieldsToCollection < ActiveRecord::Migration[5.2]
  def change
    add_column :collections, :agreed_value, :string
    add_column :collections, :no_payment_reason, :string
  end
end
