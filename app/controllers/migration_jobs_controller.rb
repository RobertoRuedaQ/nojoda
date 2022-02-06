class MigrationJobsController < ApplicationController
	def index
		@migration_job = MigrationJob.lumniStart(params,current_company, list: current_user.template('MigrationJob','migration_jobs',current_user))
		contactMigrationJob = @migration_job.lumniSave(params,current_user, list: current_user.template('MigrationJob','migration_jobs',current_user))
		lumniClose(@migration_job,contactMigrationJob)
	end

	def new
		@migration_job = MigrationJob.lumniStart(params,current_company, list: current_user.template('MigrationJob','migration_jobs',current_user))
		contactMigrationJob = @migration_job.lumniSave(params,current_user, list: current_user.template('MigrationJob','migration_jobs',current_user))
		lumniClose(@migration_job,contactMigrationJob)
	end

	def create
		@migration_job = MigrationJob.lumniStart(params,current_company, list: current_user.template('MigrationJob','migration_jobs',current_user))
		contactMigrationJob = @migration_job.lumniSave(params,current_user, list: current_user.template('MigrationJob','migration_jobs',current_user))
		lumniClose(@migration_job,contactMigrationJob)
	end

	def edit
		@migration_job = MigrationJob.lumniStart(params,current_company, list: current_user.template('MigrationJob','migration_jobs',current_user))
		contactMigrationJob = @migration_job.lumniSave(params,current_user, list: current_user.template('MigrationJob','migration_jobs',current_user))
		lumniClose(@migration_job,contactMigrationJob)
	end

	def update
		@migration_job = MigrationJob.lumniStart(params,current_company, list: current_user.template('MigrationJob','migration_jobs',current_user))
		contactMigrationJob = @migration_job.lumniSave(params,current_user, list: current_user.template('MigrationJob','migration_jobs',current_user))
		lumniClose(@migration_job,contactMigrationJob)
	end
	def destroy
		@migration_job = MigrationJob.lumniStart(params,current_company, list: current_user.template('MigrationJob','migration_jobs',current_user))
		contactMigrationJob = @migration_job.lumniSave(params,current_user, list: current_user.template('MigrationJob','migration_jobs',current_user))
		lumniClose(@cluster,contactMigrationJob)
	end
end