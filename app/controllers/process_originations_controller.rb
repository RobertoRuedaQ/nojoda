class ProcessOriginationsController < ApplicationController
	def index
		@process_origination = ProcessOrigination.lumniStart(params,current_company, list: current_user.template('ProcessOrigination','process_originations',current_user))
		contactProcessOrigination = @process_origination.lumniSave(params,current_user, list: current_user.template('ProcessOrigination','process_originations',current_user))
		lumniClose(@process_origination,contactProcessOrigination)
	end

	def new
		@process_origination = ProcessOrigination.lumniStart(params,current_company, list: current_user.template('ProcessOrigination','process_originations',current_user))
		contactProcessOrigination = @process_origination.lumniSave(params,current_user, list: current_user.template('ProcessOrigination','process_originations',current_user))
		lumniClose(@process_origination,contactProcessOrigination)
	end

	def create
		@process_origination = ProcessOrigination.lumniStart(params,current_company, list: current_user.template('ProcessOrigination','process_originations',current_user))
		contactProcessOrigination = @process_origination.lumniSave(params,current_user, list: current_user.template('ProcessOrigination','process_originations',current_user))
		lumniClose(@process_origination,contactProcessOrigination)
	end

	def edit
		@process_origination = ProcessOrigination.lumniStart(params,current_company, list: current_user.template('ProcessOrigination','process_originations',current_user))
		contactProcessOrigination = @process_origination.lumniSave(params,current_user, list: current_user.template('ProcessOrigination','process_originations',current_user))
		lumniClose(@process_origination,contactProcessOrigination)
	end

	def update
		@process_origination = ProcessOrigination.lumniStart(params,current_company, list: current_user.template('ProcessOrigination','process_originations',current_user))
		contactProcessOrigination = @process_origination.lumniSave(params,current_user, list: current_user.template('ProcessOrigination','process_originations',current_user))
		lumniClose(@process_origination,contactProcessOrigination)
	end
	def destroy
		@process_origination = ProcessOrigination.lumniStart(params,current_company, list: current_user.template('ProcessOrigination','process_originations',current_user))
		contactProcessOrigination = @process_origination.lumniSave(params,current_user, list: current_user.template('ProcessOrigination','process_originations',current_user))
		lumniClose(@cluster,contactProcessOrigination)
	end
end