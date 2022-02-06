class AddShowInHomeToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :show_in_home, :boolean, default: true
    add_column :countries, :show_in_home, :boolean, default: true
  end
end
