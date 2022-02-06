class AddPhoneSupervisorToIncomeInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :income_informations, :phone_supervisor, :string
  end
end
