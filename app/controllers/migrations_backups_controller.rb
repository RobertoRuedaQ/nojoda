class MigrationsBackupsController < ApplicationController
	def index
		@migrations_backup = MigrationsBackup.lumniStart(params,current_company, list: current_user.template('MigrationsBackup','migrations_backups',current_user))
		contactMigrationsBackup = @migrations_backup.lumniSave(params,current_user, list: current_user.template('MigrationsBackup','migrations_backups',current_user))
		lumniClose(@migrations_backup,contactMigrationsBackup)
	end

	def new
		@migrations_backup = MigrationsBackup.lumniStart(params,current_company, list: current_user.template('MigrationsBackup','migrations_backups',current_user))
		contactMigrationsBackup = @migrations_backup.lumniSave(params,current_user, list: current_user.template('MigrationsBackup','migrations_backups',current_user))
		lumniClose(@migrations_backup,contactMigrationsBackup)
	end

	def create
		@migrations_backup = MigrationsBackup.lumniStart(params,current_company, list: current_user.template('MigrationsBackup','migrations_backups',current_user))
		contactMigrationsBackup = @migrations_backup.lumniSave(params,current_user, list: current_user.template('MigrationsBackup','migrations_backups',current_user))
		lumniClose(@migrations_backup,contactMigrationsBackup)
	end

	def edit
		@migrations_backup = MigrationsBackup.lumniStart(params,current_company, list: current_user.template('MigrationsBackup','migrations_backups',current_user))
		contactMigrationsBackup = @migrations_backup.lumniSave(params,current_user, list: current_user.template('MigrationsBackup','migrations_backups',current_user))
		lumniClose(@migrations_backup,contactMigrationsBackup)
	end

	def update
		@migrations_backup = MigrationsBackup.lumniStart(params,current_company, list: current_user.template('MigrationsBackup','migrations_backups',current_user))
		contactMigrationsBackup = @migrations_backup.lumniSave(params,current_user, list: current_user.template('MigrationsBackup','migrations_backups',current_user))
		lumniClose(@migrations_backup,contactMigrationsBackup)
	end
	def destroy
		@migrations_backup = MigrationsBackup.lumniStart(params,current_company, list: current_user.template('MigrationsBackup','migrations_backups',current_user))
		contactMigrationsBackup = @migrations_backup.lumniSave(params,current_user, list: current_user.template('MigrationsBackup','migrations_backups',current_user))
		lumniClose(@cluster,contactMigrationsBackup)
	end

	def show_backup
	end
end