class MigrationAccumulation < ApplicationRecord
      
      resourcify
      audited
	belongs_to :resource, polymorphic: true
end
