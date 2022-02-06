class BackupField < ApplicationRecord
      
      resourcify
  belongs_to :backup_object
  has_many :backup_picklist
  has_many :backup_info
end
