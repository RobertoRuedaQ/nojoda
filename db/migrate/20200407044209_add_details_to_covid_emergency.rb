class AddDetailsToCovidEmergency < ActiveRecord::Migration[5.2]
  def change
    add_column :covid_emergencies, :details, :text
  end
end
