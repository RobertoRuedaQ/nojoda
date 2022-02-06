class FormListValuesController < ApplicationController
	def index
		@form_list_value = FormListValue.lumniStart(params,current_company,list: current_user.template('FormListValue','form_list_values',current_user))
		contactFormListValue = @form_list_value.lumniSave(params,current_user,list: current_user.template('FormListValue','form_list_values',current_user))
		lumniClose(@form_list_value,contactFormListValue)
	end

	def new
		@form_list_value = FormListValue.lumniStart(params,current_company,list: current_user.template('FormListValue','form_list_values',current_user))
		contactFormListValue = @form_list_value.lumniSave(params,current_user,list: current_user.template('FormListValue','form_list_values',current_user))
		lumniClose(@form_list_value,contactFormListValue)
	end

	def create
		@form_list_value = FormListValue.lumniStart(params,current_company,list: current_user.template('FormListValue','form_list_values',current_user))
		contactFormListValue = @form_list_value.lumniSave(params,current_user,list: current_user.template('FormListValue','form_list_values',current_user))
		lumniClose(@form_list_value,contactFormListValue)
	end

	def edit
		@form_list_value = FormListValue.lumniStart(params,current_company,list: current_user.template('FormListValue','form_list_values',current_user))
		contactFormListValue = @form_list_value.lumniSave(params,current_user,list: current_user.template('FormListValue','form_list_values',current_user))
		lumniClose(@form_list_value,contactFormListValue)
	end

	def update
		@form_list_value = FormListValue.lumniStart(params,current_company,list: current_user.template('FormListValue','form_list_values',current_user))
		contactFormListValue = @form_list_value.lumniSave(params,current_user,list: current_user.template('FormListValue','form_list_values',current_user))
		lumniClose(@form_list_value,contactFormListValue)
	end
	def destroy
		@form_list_value = FormListValue.lumniStart(params,current_company,list: current_user.template('FormListValue','form_list_values',current_user))
		contactFormListValue = @form_list_value.lumniSave(params,current_user,list: current_user.template('FormListValue','form_list_values',current_user))
		lumniClose(@cluster,contactFormListValue)
	end

	def modify_form_list_value
		@form_list_value = FormListValue.cached_find(params[:id])
	end
end