class AddSubmittedDateToApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :submitted_date, :date
  end
end
