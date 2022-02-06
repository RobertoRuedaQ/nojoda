class BackupPicklist < ApplicationRecord
      
      resourcify
      audited
  belongs_to :backup_field
end
