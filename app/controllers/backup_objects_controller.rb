class BackupObjectsController < ApplicationController
	def index
		@backup_object = BackupObject.lumniStart(params,current_company, list: current_user.template('BackupObject','backup_objects',current_user))
		contactBackupObject = @backup_object.lumniSave(params,current_user, list: current_user.template('BackupObject','backup_objects',current_user))
		lumniClose(@backup_object,contactBackupObject)
	end

	def new
		@backup_object = BackupObject.lumniStart(params,current_company, list: current_user.template('BackupObject','backup_objects',current_user))
		contactBackupObject = @backup_object.lumniSave(params,current_user, list: current_user.template('BackupObject','backup_objects',current_user))
		lumniClose(@backup_object,contactBackupObject)
	end

	def create
		@backup_object = BackupObject.lumniStart(params,current_company, list: current_user.template('BackupObject','backup_objects',current_user))
		contactBackupObject = @backup_object.lumniSave(params,current_user, list: current_user.template('BackupObject','backup_objects',current_user))
		lumniClose(@backup_object,contactBackupObject)
	end

	def edit
		@backup_object = BackupObject.lumniStart(params,current_company, list: current_user.template('BackupObject','backup_objects',current_user))
		contactBackupObject = @backup_object.lumniSave(params,current_user, list: current_user.template('BackupObject','backup_objects',current_user))
		lumniClose(@backup_object,contactBackupObject)
	end

	def update
		@backup_object = BackupObject.lumniStart(params,current_company, list: current_user.template('BackupObject','backup_objects',current_user))
		contactBackupObject = @backup_object.lumniSave(params,current_user, list: current_user.template('BackupObject','backup_objects',current_user))
		lumniClose(@backup_object,contactBackupObject)
	end
	def destroy
		@backup_object = BackupObject.lumniStart(params,current_company, list: current_user.template('BackupObject','backup_objects',current_user))
		contactBackupObject = @backup_object.lumniSave(params,current_user, list: current_user.template('BackupObject','backup_objects',current_user))
		lumniClose(@cluster,contactBackupObject)
	end

	def create_backup
		target_objects = ['849','390','466','568','276','378','343','502','394','221','607','605','631',
			'348','190','547','620','527','469','291','612','533','516','664','530','577',
			'482','622','500','499','600','829','277','48','468','316','532','465','393',
			'729','582','491','823','581','369','430','640','259','827','126','461','376',
			'431','349','164','623','45','628','8','536']
		objects = BackupObject.where(id: target_objects)
		objects.each do |object|
			MigrationAsync.perform_async('create_backup_migration',object.id)
		end
	end

	def create_sf_structure
		MigrationAsync.perform_async('create_sf_structure',nil)
	end
end