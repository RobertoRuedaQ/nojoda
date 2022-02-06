class AddPercentageInfoToBillingDocument < ActiveRecord::Migration[5.2]
  def change
    add_column :billing_documents, :percentage_value, :float
    add_column :billing_documents, :percentage_case, :string
  end
end
