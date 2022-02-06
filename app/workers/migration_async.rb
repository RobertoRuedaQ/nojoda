class MigrationAsync < ApplicationController
	include Sidekiq::Worker
	include LumniMigration
	include LumniRoles

	sidekiq_options queue: 'heavy_work'
	sidekiq_retry_in do |count|
    	([[(Migration.pending_tracking).to_i,1600].min,50].max * rand).to_i + 30
    end
    Sidekiq.default_worker_options['retry'] = 100000

	def perform target_method,target_ids, options = {}
		eval("#{target_method} target_ids")
	end
end