class AddStatusToConciliationInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :conciliation_informations, :status, :string
  end
end
