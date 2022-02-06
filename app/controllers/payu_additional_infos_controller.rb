class PayuAdditionalInfosController < ApplicationController
	def index
		@payu_additional_info = PayuAdditionalInfo.lumniStart(params,current_company, list: current_user.template('PayuAdditionalInfo','payu_additional_infos',current_user))
		contactPayuAdditionalInfo = @payu_additional_info.lumniSave(params,current_user, list: current_user.template('PayuAdditionalInfo','payu_additional_infos',current_user))
		lumniClose(@payu_additional_info,contactPayuAdditionalInfo)
	end

	def new
		@payu_additional_info = PayuAdditionalInfo.lumniStart(params,current_company, list: current_user.template('PayuAdditionalInfo','payu_additional_infos',current_user))
		contactPayuAdditionalInfo = @payu_additional_info.lumniSave(params,current_user, list: current_user.template('PayuAdditionalInfo','payu_additional_infos',current_user))
		lumniClose(@payu_additional_info,contactPayuAdditionalInfo)
	end

	def create
		@payu_additional_info = PayuAdditionalInfo.lumniStart(params,current_company, list: current_user.template('PayuAdditionalInfo','payu_additional_infos',current_user))
		contactPayuAdditionalInfo = @payu_additional_info.lumniSave(params,current_user, list: current_user.template('PayuAdditionalInfo','payu_additional_infos',current_user))
		lumniClose(@payu_additional_info,contactPayuAdditionalInfo)
	end

	def edit
		@payu_additional_info = PayuAdditionalInfo.lumniStart(params,current_company, list: current_user.template('PayuAdditionalInfo','payu_additional_infos',current_user))
		contactPayuAdditionalInfo = @payu_additional_info.lumniSave(params,current_user, list: current_user.template('PayuAdditionalInfo','payu_additional_infos',current_user))
		lumniClose(@payu_additional_info,contactPayuAdditionalInfo)
	end

	def update
		@payu_additional_info = PayuAdditionalInfo.lumniStart(params,current_company, list: current_user.template('PayuAdditionalInfo','payu_additional_infos',current_user))
		contactPayuAdditionalInfo = @payu_additional_info.lumniSave(params,current_user, list: current_user.template('PayuAdditionalInfo','payu_additional_infos',current_user))
		lumniClose(@payu_additional_info,contactPayuAdditionalInfo)
	end
	def destroy
		@payu_additional_info = PayuAdditionalInfo.lumniStart(params,current_company, list: current_user.template('PayuAdditionalInfo','payu_additional_infos',current_user))
		contactPayuAdditionalInfo = @payu_additional_info.lumniSave(params,current_user, list: current_user.template('PayuAdditionalInfo','payu_additional_infos',current_user))
		lumniClose(@cluster,contactPayuAdditionalInfo)
	end
end