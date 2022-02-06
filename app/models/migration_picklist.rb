class MigrationPicklist < ApplicationRecord
      
      resourcify
      audited
  belongs_to :migration_field
end
