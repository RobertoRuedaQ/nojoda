class FormFieldsController < ApplicationController
	def index
		@form_field = FormField.lumniStart(params,current_company)
		contactFormField = @form_field.lumniSave(params,current_user)
		lumniClose(@form_field,contactFormField)
	end

	def new
		@form_field = FormField.lumniStart(params,current_company)
		contactFormField = @form_field.lumniSave(params,current_user)
		lumniClose(@form_field,contactFormField)
	end

	def create
		@form_field = FormField.lumniStart(params,current_company)
		contactFormField = @form_field.lumniSave(params,current_user)
		lumniClose(@form_field,contactFormField)
	end

	def edit
		@form_field = FormField.lumniStart(params,current_company)
		contactFormField = @form_field.lumniSave(params,current_user)
		lumniClose(@form_field,contactFormField)
	end

	def update
		@form_field = FormField.lumniStart(params,current_company)

		@form_template = @form_field.form_template
#		@form_template.flush_cached_field_info

		contactFormField = @form_field.lumniSave(params,current_user)
		lumniClose(@form_field,contactFormField)

		@form_template.flush_cached_field_info
		@field_attributes = @form_template.cached_field_info(current_user,current_company)
	end

	def edit_file_field
		@target_record = eval("#{params[:target_model]}.cached_find(params[:object_id])")
	end
	def destroy
		@form_field = FormField.lumniStart(params,current_company)
		contactFormField = @form_field.lumniSave(params,current_user)
		lumniClose(@cluster,contactFormField)
	end
end