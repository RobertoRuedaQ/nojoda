class AddEmploymentStoredStatusToIsa < ActiveRecord::Migration[5.2]
  def change
    add_column :isas, :stored_employment_status, :string
  end
end
