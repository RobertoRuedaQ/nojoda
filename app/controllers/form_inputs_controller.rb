class FormInputsController < ApplicationController
	def index
		@form_input = FormInput.lumniStart(params,current_company, list: current_user.template('FormInput','form_inputs',current_user))
		contactFormInput = @form_input.lumniSave(params,current_user, list: current_user.template('FormInput','form_inputs',current_user))
		lumniClose(@form_input,contactFormInput)
	end

	def new
		@form_input = FormInput.lumniStart(params,current_company, list: current_user.template('FormInput','form_inputs',current_user))
		contactFormInput = @form_input.lumniSave(params,current_user, list: current_user.template('FormInput','form_inputs',current_user))
		lumniClose(@form_input,contactFormInput)
	end

	def create
		@form_input = FormInput.lumniStart(params,current_company, list: current_user.template('FormInput','form_inputs',current_user))
		contactFormInput = @form_input.lumniSave(params,current_user, list: current_user.template('FormInput','form_inputs',current_user))
		lumniClose(@form_input,contactFormInput)
	end

	def edit
		@form_input = FormInput.lumniStart(params,current_company, list: current_user.template('FormInput','form_inputs',current_user))
		contactFormInput = @form_input.lumniSave(params,current_user, list: current_user.template('FormInput','form_inputs',current_user))
		lumniClose(@form_input,contactFormInput)
	end

	def update
		@form_input = FormInput.lumniStart(params,current_company, list: current_user.template('FormInput','form_inputs',current_user))
		contactFormInput = @form_input.lumniSave(params,current_user, list: current_user.template('FormInput','form_inputs',current_user))
		lumniClose(@form_input,contactFormInput)
	end
	def destroy
		@form_input = FormInput.lumniStart(params,current_company, list: current_user.template('FormInput','form_inputs',current_user))
		contactFormInput = @form_input.lumniSave(params,current_user, list: current_user.template('FormInput','form_inputs',current_user))
		lumniClose(@cluster,contactFormInput)
	end
end