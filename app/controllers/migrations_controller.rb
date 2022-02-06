class MigrationsController < ApplicationController
	include LumniMigration
	def index
		@migration = Migration.lumniStart(params,current_company, list: current_user.template('Migration','migrations',current_user))
		contactMigration = @migration.lumniSave(params,current_user, list: current_user.template('Migration','migrations',current_user))
		lumniClose(@migration,contactMigration)
	end

	def new
		@migration = Migration.lumniStart(params,current_company, list: current_user.template('Migration','migrations',current_user))
		contactMigration = @migration.lumniSave(params,current_user, list: current_user.template('Migration','migrations',current_user))
		lumniClose(@migration,contactMigration)
	end

	def create
		@migration = Migration.lumniStart(params,current_company, list: current_user.template('Migration','migrations',current_user))
		contactMigration = @migration.lumniSave(params,current_user, list: current_user.template('Migration','migrations',current_user))
		lumniClose(@migration,contactMigration)
	end

	def edit
		@migration = Migration.lumniStart(params,current_company, list: current_user.template('Migration','migrations',current_user))
		contactMigration = @migration.lumniSave(params,current_user, list: current_user.template('Migration','migrations',current_user))
		lumniClose(@migration,contactMigration)
	end

	def update
		@migration = Migration.lumniStart(params,current_company, list: current_user.template('Migration','migrations',current_user))
		contactMigration = @migration.lumniSave(params,current_user, list: current_user.template('Migration','migrations',current_user))
		lumniClose(@migration,contactMigration)
	end
	def destroy
		@migration = Migration.lumniStart(params,current_company, list: current_user.template('Migration','migrations',current_user))
		contactMigration = @migration.lumniSave(params,current_user, list: current_user.template('Migration','migrations',current_user))
		lumniClose(@cluster,contactMigration)
	end

	def general_migrations

		target_ids = Migration.migration_order
		Migration.where(id: target_ids).update_all(notes: nil)

	    if Rails.env == 'production'
	      MigrationAsync.perform_async('main_migration_method',target_ids)
	    else
	      main_migration_method(target_ids)
	    end
	    redirect_to migrations_path
	end

	def reset_job
		Migration.reset_job
		redirect_to migrations_path
	end

	def process_migration_tracking
		process_migration_group params[:id]
		redirect_to migrations_path
	end
end
