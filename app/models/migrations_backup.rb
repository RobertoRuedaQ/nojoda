class MigrationsBackup < ApplicationRecord
      
      resourcify
      audited
  belongs_to :migration
  belongs_to :user
end
