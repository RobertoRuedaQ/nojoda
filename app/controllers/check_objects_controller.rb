class CheckObjectsController < ApplicationController
	def index
		@check_object = CheckObject.lumniStart(params,current_company, list: current_user.template('CheckObject','check_objects',current_user)).clean
		contactCheckObject = @check_object.lumniSave(params,current_user, list: current_user.template('CheckObject','check_objects',current_user))
		lumniClose(@check_object,contactCheckObject)
	end

	def new
		@check_object = CheckObject.lumniStart(params,current_company, list: current_user.template('CheckObject','check_objects',current_user))
		contactCheckObject = @check_object.lumniSave(params,current_user, list: current_user.template('CheckObject','check_objects',current_user))
		lumniClose(@check_object,contactCheckObject)
	end

	def create
		@check_object = CheckObject.lumniStart(params,current_company, list: current_user.template('CheckObject','check_objects',current_user))
		contactCheckObject = @check_object.lumniSave(params,current_user, list: current_user.template('CheckObject','check_objects',current_user))
		lumniClose(@check_object,contactCheckObject)
	end

	def edit
		@check_object = CheckObject.lumniStart(params,current_company, list: current_user.template('CheckObject','check_objects',current_user))
		contactCheckObject = @check_object.lumniSave(params,current_user, list: current_user.template('CheckObject','check_objects',current_user))
		lumniClose(@check_object,contactCheckObject)
	end

	def update
		@check_object = CheckObject.lumniStart(params,current_company, list: current_user.template('CheckObject','check_objects',current_user))
		contactCheckObject = @check_object.lumniSave(params,current_user, list: current_user.template('CheckObject','check_objects',current_user))
		lumniClose(@check_object,contactCheckObject)
	end
	def destroy
		@check_object = CheckObject.lumniStart(params,current_company, list: current_user.template('CheckObject','check_objects',current_user))
		contactCheckObject = @check_object.lumniSave(params,current_user, list: current_user.template('CheckObject','check_objects',current_user))
		lumniClose(@cluster,contactCheckObject)
	end
	def update_objects
		MigrationAsync.perform_async('statistics_from_sf',nil)
		redirect_to check_objects_path
	end
end