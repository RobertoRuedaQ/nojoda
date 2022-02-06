class PayuExtraParamsController < ApplicationController
	def index
		@payu_extra_param = PayuExtraParam.lumniStart(params,current_company, list: current_user.template('PayuExtraParam','payu_extra_params',current_user))
		contactPayuExtraParam = @payu_extra_param.lumniSave(params,current_user, list: current_user.template('PayuExtraParam','payu_extra_params',current_user))
		lumniClose(@payu_extra_param,contactPayuExtraParam)
	end

	def new
		@payu_extra_param = PayuExtraParam.lumniStart(params,current_company, list: current_user.template('PayuExtraParam','payu_extra_params',current_user))
		contactPayuExtraParam = @payu_extra_param.lumniSave(params,current_user, list: current_user.template('PayuExtraParam','payu_extra_params',current_user))
		lumniClose(@payu_extra_param,contactPayuExtraParam)
	end

	def create
		@payu_extra_param = PayuExtraParam.lumniStart(params,current_company, list: current_user.template('PayuExtraParam','payu_extra_params',current_user))
		contactPayuExtraParam = @payu_extra_param.lumniSave(params,current_user, list: current_user.template('PayuExtraParam','payu_extra_params',current_user))
		lumniClose(@payu_extra_param,contactPayuExtraParam)
	end

	def edit
		@payu_extra_param = PayuExtraParam.lumniStart(params,current_company, list: current_user.template('PayuExtraParam','payu_extra_params',current_user))
		contactPayuExtraParam = @payu_extra_param.lumniSave(params,current_user, list: current_user.template('PayuExtraParam','payu_extra_params',current_user))
		lumniClose(@payu_extra_param,contactPayuExtraParam)
	end

	def update
		@payu_extra_param = PayuExtraParam.lumniStart(params,current_company, list: current_user.template('PayuExtraParam','payu_extra_params',current_user))
		contactPayuExtraParam = @payu_extra_param.lumniSave(params,current_user, list: current_user.template('PayuExtraParam','payu_extra_params',current_user))
		lumniClose(@payu_extra_param,contactPayuExtraParam)
	end
	def destroy
		@payu_extra_param = PayuExtraParam.lumniStart(params,current_company, list: current_user.template('PayuExtraParam','payu_extra_params',current_user))
		contactPayuExtraParam = @payu_extra_param.lumniSave(params,current_user, list: current_user.template('PayuExtraParam','payu_extra_params',current_user))
		lumniClose(@cluster,contactPayuExtraParam)
	end
end