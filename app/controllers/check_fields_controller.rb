class CheckFieldsController < ApplicationController
	def index
		@check_field = CheckField.lumniStart(params,current_company, list: current_user.template('CheckField','check_fields',current_user))
		contactCheckField = @check_field.lumniSave(params,current_user, list: current_user.template('CheckField','check_fields',current_user))
		lumniClose(@check_field,contactCheckField)
	end

	def new
		@check_field = CheckField.lumniStart(params,current_company, list: current_user.template('CheckField','check_fields',current_user))
		contactCheckField = @check_field.lumniSave(params,current_user, list: current_user.template('CheckField','check_fields',current_user))
		lumniClose(@check_field,contactCheckField)
	end

	def create
		@check_field = CheckField.lumniStart(params,current_company, list: current_user.template('CheckField','check_fields',current_user))
		contactCheckField = @check_field.lumniSave(params,current_user, list: current_user.template('CheckField','check_fields',current_user))
		lumniClose(@check_field,contactCheckField)
	end

	def edit
		@check_field = CheckField.lumniStart(params,current_company, list: current_user.template('CheckField','check_fields',current_user))
		contactCheckField = @check_field.lumniSave(params,current_user, list: current_user.template('CheckField','check_fields',current_user))
		lumniClose(@check_field,contactCheckField)
	end

	def update
		@check_field = CheckField.lumniStart(params,current_company, list: current_user.template('CheckField','check_fields',current_user))
		contactCheckField = @check_field.lumniSave(params,current_user, list: current_user.template('CheckField','check_fields',current_user))
		lumniClose(@check_field,contactCheckField)
	end
	def destroy
		@check_field = CheckField.lumniStart(params,current_company, list: current_user.template('CheckField','check_fields',current_user))
		contactCheckField = @check_field.lumniSave(params,current_user, list: current_user.template('CheckField','check_fields',current_user))
		lumniClose(@cluster,contactCheckField)
	end
end