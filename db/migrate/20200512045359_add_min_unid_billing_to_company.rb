class AddMinUnidBillingToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :min_unid_collection, :float
  end
end
