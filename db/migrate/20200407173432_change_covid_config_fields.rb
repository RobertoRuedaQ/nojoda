class ChangeCovidConfigFields < ActiveRecord::Migration[5.2]
  def change
	  change_column :covid_configs, :normal, :string
	  change_column :covid_configs, :due_date, :string
	  change_column :covid_configs, :payment_agreement, :string
	  change_column :covid_configs, :custom_adjustment, :string
	  change_column :covid_configs, :no_payment, :string
  end
end


