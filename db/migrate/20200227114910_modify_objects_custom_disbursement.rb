class ModifyObjectsCustomDisbursement < ActiveRecord::Migration[5.2]
  def change
    remove_column :modelings, :custom_disbursements, :string
    add_column :custom_disbursements, :target_email, :string
    add_column :custom_disbursements, :token, :string
    add_column :modelings, :custom_disbursements, :boolean
  end
end
