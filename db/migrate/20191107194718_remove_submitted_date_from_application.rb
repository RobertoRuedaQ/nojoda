class RemoveSubmittedDateFromApplication < ActiveRecord::Migration[5.2]
  def change
    remove_column :applications, :submitted_date, :date
  end
end
