class AddCustomDisbursementsToModeling < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :custom_disbursements, :disbursements
  end
end
