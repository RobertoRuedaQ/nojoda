class MigrationTracking < ApplicationRecord
	include LumniMigration
      
      resourcify
      audited
  belongs_to :migration_job

  after_create :start_processing_data

  def start_processing_data
    if Rails.env == 'production' && self.status == 'regular'
      MigrationAsync.perform_async('process_migration_group',self.id)
    else
	  	process_migration_group self.id
    end
  end

  def make_it_done
    number = eval(self.backup).count
    self.udpdate(processed_records: number.to_i)
  end

end
