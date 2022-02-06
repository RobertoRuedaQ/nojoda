class AddDefaultMonthsToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :default_months, :integer
  end
end
