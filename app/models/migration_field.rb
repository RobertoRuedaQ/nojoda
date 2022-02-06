class MigrationField < ApplicationRecord
      
      resourcify
      audited

      belongs_to :migration
end
