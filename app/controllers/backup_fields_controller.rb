class BackupFieldsController < ApplicationController
	def index
		@backup_field = BackupField.lumniStart(params,current_company, list: current_user.template('BackupField','backup_fields',current_user))
		contactBackupField = @backup_field.lumniSave(params,current_user, list: current_user.template('BackupField','backup_fields',current_user))
		lumniClose(@backup_field,contactBackupField)
	end

	def new
		@backup_field = BackupField.lumniStart(params,current_company, list: current_user.template('BackupField','backup_fields',current_user))
		contactBackupField = @backup_field.lumniSave(params,current_user, list: current_user.template('BackupField','backup_fields',current_user))
		lumniClose(@backup_field,contactBackupField)
	end

	def create
		@backup_field = BackupField.lumniStart(params,current_company, list: current_user.template('BackupField','backup_fields',current_user))
		contactBackupField = @backup_field.lumniSave(params,current_user, list: current_user.template('BackupField','backup_fields',current_user))
		lumniClose(@backup_field,contactBackupField)
	end

	def edit
		@backup_field = BackupField.lumniStart(params,current_company, list: current_user.template('BackupField','backup_fields',current_user))
		contactBackupField = @backup_field.lumniSave(params,current_user, list: current_user.template('BackupField','backup_fields',current_user))
		lumniClose(@backup_field,contactBackupField)
	end

	def update
		@backup_field = BackupField.lumniStart(params,current_company, list: current_user.template('BackupField','backup_fields',current_user))
		contactBackupField = @backup_field.lumniSave(params,current_user, list: current_user.template('BackupField','backup_fields',current_user))
		lumniClose(@backup_field,contactBackupField)
	end
	def destroy
		@backup_field = BackupField.lumniStart(params,current_company, list: current_user.template('BackupField','backup_fields',current_user))
		contactBackupField = @backup_field.lumniSave(params,current_user, list: current_user.template('BackupField','backup_fields',current_user))
		lumniClose(@cluster,contactBackupField)
	end
end