class CheckModesController < ApplicationController
	def index
		@check_mode = CheckMode.lumniStart(params,current_company, list: current_user.template('CheckMode','check_modes',current_user))
		contactCheckMode = @check_mode.lumniSave(params,current_user, list: current_user.template('CheckMode','check_modes',current_user))
		lumniClose(@check_mode,contactCheckMode)
	end

	def new
		@check_mode = CheckMode.lumniStart(params,current_company, list: current_user.template('CheckMode','check_modes',current_user))
		contactCheckMode = @check_mode.lumniSave(params,current_user, list: current_user.template('CheckMode','check_modes',current_user))
		lumniClose(@check_mode,contactCheckMode)
	end

	def create
		@check_mode = CheckMode.lumniStart(params,current_company, list: current_user.template('CheckMode','check_modes',current_user))
		contactCheckMode = @check_mode.lumniSave(params,current_user, list: current_user.template('CheckMode','check_modes',current_user))
		lumniClose(@check_mode,contactCheckMode)
	end

	def edit
		@check_mode = CheckMode.lumniStart(params,current_company, list: current_user.template('CheckMode','check_modes',current_user))
		contactCheckMode = @check_mode.lumniSave(params,current_user, list: current_user.template('CheckMode','check_modes',current_user))
		lumniClose(@check_mode,contactCheckMode)
	end

	def update
		@check_mode = CheckMode.lumniStart(params,current_company, list: current_user.template('CheckMode','check_modes',current_user))
		contactCheckMode = @check_mode.lumniSave(params,current_user, list: current_user.template('CheckMode','check_modes',current_user))
		lumniClose(@check_mode,contactCheckMode)
	end
	def destroy
		@check_mode = CheckMode.lumniStart(params,current_company, list: current_user.template('CheckMode','check_modes',current_user))
		contactCheckMode = @check_mode.lumniSave(params,current_user, list: current_user.template('CheckMode','check_modes',current_user))
		lumniClose(@cluster,contactCheckMode)
	end
end