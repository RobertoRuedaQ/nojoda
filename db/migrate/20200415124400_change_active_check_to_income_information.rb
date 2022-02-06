class ChangeActiveCheckToIncomeInformation < ActiveRecord::Migration[5.2]
  def change
	change_column :income_informations, :active_check, :boolean, default: true
  end
end
