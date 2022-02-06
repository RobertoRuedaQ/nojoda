class AddTargetDateToIpc < ActiveRecord::Migration[5.2]
  def change
    add_column :ipcs, :target_date, :date
  end
end
