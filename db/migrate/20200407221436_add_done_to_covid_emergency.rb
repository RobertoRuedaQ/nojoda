class AddDoneToCovidEmergency < ActiveRecord::Migration[5.2]
  def change
    add_column :covid_emergencies, :done, :boolean
  end
end
