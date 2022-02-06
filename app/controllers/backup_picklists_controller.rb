class BackupPicklistsController < ApplicationController
	def index
		@backup_picklist = BackupPicklist.lumniStart(params,current_company, list: current_user.template('BackupPicklist','backup_picklists',current_user))
		contactBackupPicklist = @backup_picklist.lumniSave(params,current_user, list: current_user.template('BackupPicklist','backup_picklists',current_user))
		lumniClose(@backup_picklist,contactBackupPicklist)
	end

	def new
		@backup_picklist = BackupPicklist.lumniStart(params,current_company, list: current_user.template('BackupPicklist','backup_picklists',current_user))
		contactBackupPicklist = @backup_picklist.lumniSave(params,current_user, list: current_user.template('BackupPicklist','backup_picklists',current_user))
		lumniClose(@backup_picklist,contactBackupPicklist)
	end

	def create
		@backup_picklist = BackupPicklist.lumniStart(params,current_company, list: current_user.template('BackupPicklist','backup_picklists',current_user))
		contactBackupPicklist = @backup_picklist.lumniSave(params,current_user, list: current_user.template('BackupPicklist','backup_picklists',current_user))
		lumniClose(@backup_picklist,contactBackupPicklist)
	end

	def edit
		@backup_picklist = BackupPicklist.lumniStart(params,current_company, list: current_user.template('BackupPicklist','backup_picklists',current_user))
		contactBackupPicklist = @backup_picklist.lumniSave(params,current_user, list: current_user.template('BackupPicklist','backup_picklists',current_user))
		lumniClose(@backup_picklist,contactBackupPicklist)
	end

	def update
		@backup_picklist = BackupPicklist.lumniStart(params,current_company, list: current_user.template('BackupPicklist','backup_picklists',current_user))
		contactBackupPicklist = @backup_picklist.lumniSave(params,current_user, list: current_user.template('BackupPicklist','backup_picklists',current_user))
		lumniClose(@backup_picklist,contactBackupPicklist)
	end
	def destroy
		@backup_picklist = BackupPicklist.lumniStart(params,current_company, list: current_user.template('BackupPicklist','backup_picklists',current_user))
		contactBackupPicklist = @backup_picklist.lumniSave(params,current_user, list: current_user.template('BackupPicklist','backup_picklists',current_user))
		lumniClose(@cluster,contactBackupPicklist)
	end
end