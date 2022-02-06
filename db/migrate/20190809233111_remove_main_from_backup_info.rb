class RemoveMainFromBackupInfo < ActiveRecord::Migration[5.2]
  def change
    remove_reference :backup_infos, :main, index: true
  end
end
