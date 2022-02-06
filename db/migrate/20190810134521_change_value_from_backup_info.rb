class ChangeValueFromBackupInfo < ActiveRecord::Migration[5.2]
  def change
  	change_column :backup_infos, :value, :text
  end
end
