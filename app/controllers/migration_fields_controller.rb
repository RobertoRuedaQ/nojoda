class MigrationFieldsController < ApplicationController
	def index
		@migration_field = MigrationField.lumniStart(params,current_company, list: current_user.template('MigrationField','migration_fields',current_user))
		contactMigrationField = @migration_field.lumniSave(params,current_user, list: current_user.template('MigrationField','migration_fields',current_user))
		lumniClose(@migration_field,contactMigrationField)
	end

	def new
		@migration_field = MigrationField.lumniStart(params,current_company, list: current_user.template('MigrationField','migration_fields',current_user))
		contactMigrationField = @migration_field.lumniSave(params,current_user, list: current_user.template('MigrationField','migration_fields',current_user))
		lumniClose(@migration_field,contactMigrationField)
	end

	def create
		@migration_field = MigrationField.lumniStart(params,current_company, list: current_user.template('MigrationField','migration_fields',current_user))
		contactMigrationField = @migration_field.lumniSave(params,current_user, list: current_user.template('MigrationField','migration_fields',current_user))
		lumniClose(@migration_field,contactMigrationField)
	end

	def edit
		@migration_field = MigrationField.lumniStart(params,current_company, list: current_user.template('MigrationField','migration_fields',current_user))
		contactMigrationField = @migration_field.lumniSave(params,current_user, list: current_user.template('MigrationField','migration_fields',current_user))
		lumniClose(@migration_field,contactMigrationField)
	end

	def update
		@migration_field = MigrationField.lumniStart(params,current_company, list: current_user.template('MigrationField','migration_fields',current_user))
		contactMigrationField = @migration_field.lumniSave(params,current_user, list: current_user.template('MigrationField','migration_fields',current_user))
		lumniClose(@migration_field,contactMigrationField)
	end
	def destroy
		@migration_field = MigrationField.lumniStart(params,current_company, list: current_user.template('MigrationField','migration_fields',current_user))
		contactMigrationField = @migration_field.lumniSave(params,current_user, list: current_user.template('MigrationField','migration_fields',current_user))
		lumniClose(@cluster,contactMigrationField)
	end
end