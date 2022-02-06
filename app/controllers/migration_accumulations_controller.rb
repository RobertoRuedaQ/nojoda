class MigrationAccumulationsController < ApplicationController
	def index
		@migration_accumulation = MigrationAccumulation.lumniStart(params,current_company, list: current_user.template('MigrationAccumulation','migration_accumulations',current_user))
		contactMigrationAccumulation = @migration_accumulation.lumniSave(params,current_user, list: current_user.template('MigrationAccumulation','migration_accumulations',current_user))
		lumniClose(@migration_accumulation,contactMigrationAccumulation)
	end

	def new
		@migration_accumulation = MigrationAccumulation.lumniStart(params,current_company, list: current_user.template('MigrationAccumulation','migration_accumulations',current_user))
		contactMigrationAccumulation = @migration_accumulation.lumniSave(params,current_user, list: current_user.template('MigrationAccumulation','migration_accumulations',current_user))
		lumniClose(@migration_accumulation,contactMigrationAccumulation)
	end

	def create
		@migration_accumulation = MigrationAccumulation.lumniStart(params,current_company, list: current_user.template('MigrationAccumulation','migration_accumulations',current_user))
		contactMigrationAccumulation = @migration_accumulation.lumniSave(params,current_user, list: current_user.template('MigrationAccumulation','migration_accumulations',current_user))
		lumniClose(@migration_accumulation,contactMigrationAccumulation)
	end

	def edit
		@migration_accumulation = MigrationAccumulation.lumniStart(params,current_company, list: current_user.template('MigrationAccumulation','migration_accumulations',current_user))
		contactMigrationAccumulation = @migration_accumulation.lumniSave(params,current_user, list: current_user.template('MigrationAccumulation','migration_accumulations',current_user))
		lumniClose(@migration_accumulation,contactMigrationAccumulation)
	end

	def update
		@migration_accumulation = MigrationAccumulation.lumniStart(params,current_company, list: current_user.template('MigrationAccumulation','migration_accumulations',current_user))
		contactMigrationAccumulation = @migration_accumulation.lumniSave(params,current_user, list: current_user.template('MigrationAccumulation','migration_accumulations',current_user))
		lumniClose(@migration_accumulation,contactMigrationAccumulation)
	end
	def destroy
		@migration_accumulation = MigrationAccumulation.lumniStart(params,current_company, list: current_user.template('MigrationAccumulation','migration_accumulations',current_user))
		contactMigrationAccumulation = @migration_accumulation.lumniSave(params,current_user, list: current_user.template('MigrationAccumulation','migration_accumulations',current_user))
		lumniClose(@cluster,contactMigrationAccumulation)
	end
end