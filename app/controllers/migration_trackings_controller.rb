class MigrationTrackingsController < ApplicationController
	def index
		@migration_tracking = MigrationTracking.lumniStart(params,current_company, list: current_user.template('MigrationTracking','migration_trackings',current_user))
		contactMigrationTracking = @migration_tracking.lumniSave(params,current_user, list: current_user.template('MigrationTracking','migration_trackings',current_user))
		lumniClose(@migration_tracking,contactMigrationTracking)
	end

	def new
		@migration_tracking = MigrationTracking.lumniStart(params,current_company, list: current_user.template('MigrationTracking','migration_trackings',current_user))
		contactMigrationTracking = @migration_tracking.lumniSave(params,current_user, list: current_user.template('MigrationTracking','migration_trackings',current_user))
		lumniClose(@migration_tracking,contactMigrationTracking)
	end

	def create
		@migration_tracking = MigrationTracking.lumniStart(params,current_company, list: current_user.template('MigrationTracking','migration_trackings',current_user))
		contactMigrationTracking = @migration_tracking.lumniSave(params,current_user, list: current_user.template('MigrationTracking','migration_trackings',current_user))
		lumniClose(@migration_tracking,contactMigrationTracking)
	end

	def edit
		@migration_tracking = MigrationTracking.lumniStart(params,current_company, list: current_user.template('MigrationTracking','migration_trackings',current_user))
		contactMigrationTracking = @migration_tracking.lumniSave(params,current_user, list: current_user.template('MigrationTracking','migration_trackings',current_user))
		lumniClose(@migration_tracking,contactMigrationTracking)
	end

	def update
		@migration_tracking = MigrationTracking.lumniStart(params,current_company, list: current_user.template('MigrationTracking','migration_trackings',current_user))
		contactMigrationTracking = @migration_tracking.lumniSave(params,current_user, list: current_user.template('MigrationTracking','migration_trackings',current_user))
		lumniClose(@migration_tracking,contactMigrationTracking)
	end
	def destroy
		@migration_tracking = MigrationTracking.lumniStart(params,current_company, list: current_user.template('MigrationTracking','migration_trackings',current_user))
		contactMigrationTracking = @migration_tracking.lumniSave(params,current_user, list: current_user.template('MigrationTracking','migration_trackings',current_user))
		lumniClose(@cluster,contactMigrationTracking)
	end
end