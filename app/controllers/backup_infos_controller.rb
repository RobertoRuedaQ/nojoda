class BackupInfosController < ApplicationController
	def index
		@backup_info = BackupInfo.lumniStart(params,current_company, list: current_user.template('BackupInfo','backup_infos',current_user))
		contactBackupInfo = @backup_info.lumniSave(params,current_user, list: current_user.template('BackupInfo','backup_infos',current_user))
		lumniClose(@backup_info,contactBackupInfo)
	end

	def new
		@backup_info = BackupInfo.lumniStart(params,current_company, list: current_user.template('BackupInfo','backup_infos',current_user))
		contactBackupInfo = @backup_info.lumniSave(params,current_user, list: current_user.template('BackupInfo','backup_infos',current_user))
		lumniClose(@backup_info,contactBackupInfo)
	end

	def create
		@backup_info = BackupInfo.lumniStart(params,current_company, list: current_user.template('BackupInfo','backup_infos',current_user))
		contactBackupInfo = @backup_info.lumniSave(params,current_user, list: current_user.template('BackupInfo','backup_infos',current_user))
		lumniClose(@backup_info,contactBackupInfo)
	end

	def edit
		@backup_info = BackupInfo.lumniStart(params,current_company, list: current_user.template('BackupInfo','backup_infos',current_user))
		contactBackupInfo = @backup_info.lumniSave(params,current_user, list: current_user.template('BackupInfo','backup_infos',current_user))
		lumniClose(@backup_info,contactBackupInfo)
	end

	def update
		@backup_info = BackupInfo.lumniStart(params,current_company, list: current_user.template('BackupInfo','backup_infos',current_user))
		contactBackupInfo = @backup_info.lumniSave(params,current_user, list: current_user.template('BackupInfo','backup_infos',current_user))
		lumniClose(@backup_info,contactBackupInfo)
	end
	def destroy
		@backup_info = BackupInfo.lumniStart(params,current_company, list: current_user.template('BackupInfo','backup_infos',current_user))
		contactBackupInfo = @backup_info.lumniSave(params,current_user, list: current_user.template('BackupInfo','backup_infos',current_user))
		lumniClose(@cluster,contactBackupInfo)
	end
end