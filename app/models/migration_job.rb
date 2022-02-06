class MigrationJob < ApplicationRecord
	include LumniMigration
      
      resourcify
      audited
  belongs_to :migration
  has_many :migration_tracking, dependent: :destroy

  after_create :start_remote

  def start_remote
    MigrationAsync.perform_async('restart_target_job',self.id)
  end

  def status_array
	target_array = eval(self.target_array)
	array_index = target_array.index(target_migration.id)

  end

  def start_migration
  		self.migration_tracking.destroy_all
		  migration_import_and_process self
  end


end
