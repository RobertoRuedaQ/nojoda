class MigrationPicklistsController < ApplicationController
	def index
		@migration_picklist = MigrationPicklist.lumniStart(params,current_company, list: current_user.template('MigrationPicklist','migration_picklists',current_user))
		contactMigrationPicklist = @migration_picklist.lumniSave(params,current_user, list: current_user.template('MigrationPicklist','migration_picklists',current_user))
		lumniClose(@migration_picklist,contactMigrationPicklist)
	end

	def new
		@migration_picklist = MigrationPicklist.lumniStart(params,current_company, list: current_user.template('MigrationPicklist','migration_picklists',current_user))
		contactMigrationPicklist = @migration_picklist.lumniSave(params,current_user, list: current_user.template('MigrationPicklist','migration_picklists',current_user))
		lumniClose(@migration_picklist,contactMigrationPicklist)
	end

	def create
		@migration_picklist = MigrationPicklist.lumniStart(params,current_company, list: current_user.template('MigrationPicklist','migration_picklists',current_user))
		contactMigrationPicklist = @migration_picklist.lumniSave(params,current_user, list: current_user.template('MigrationPicklist','migration_picklists',current_user))
		lumniClose(@migration_picklist,contactMigrationPicklist)
	end

	def edit
		@migration_picklist = MigrationPicklist.lumniStart(params,current_company, list: current_user.template('MigrationPicklist','migration_picklists',current_user))
		contactMigrationPicklist = @migration_picklist.lumniSave(params,current_user, list: current_user.template('MigrationPicklist','migration_picklists',current_user))
		lumniClose(@migration_picklist,contactMigrationPicklist)
	end

	def update
		@migration_picklist = MigrationPicklist.lumniStart(params,current_company, list: current_user.template('MigrationPicklist','migration_picklists',current_user))
		contactMigrationPicklist = @migration_picklist.lumniSave(params,current_user, list: current_user.template('MigrationPicklist','migration_picklists',current_user))
		lumniClose(@migration_picklist,contactMigrationPicklist)
	end
	def destroy
		@migration_picklist = MigrationPicklist.lumniStart(params,current_company, list: current_user.template('MigrationPicklist','migration_picklists',current_user))
		contactMigrationPicklist = @migration_picklist.lumniSave(params,current_user, list: current_user.template('MigrationPicklist','migration_picklists',current_user))
		lumniClose(@cluster,contactMigrationPicklist)
	end
end