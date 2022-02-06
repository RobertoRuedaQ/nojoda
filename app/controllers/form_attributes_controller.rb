class FormAttributesController < ApplicationController
	def index
		@form_attribute = FormAttribute.lumniStart(params,current_company)
		contactFormAttribute = @form_attribute.lumniSave(params,current_user)
		lumniClose(@form_attribute,contactFormAttribute)
	end

	def new
		@form_attribute = FormAttribute.lumniStart(params,current_company)
		contactFormAttribute = @form_attribute.lumniSave(params,current_user)
		lumniClose(@form_attribute,contactFormAttribute)
	end

	def create
		@form_attribute = FormAttribute.lumniStart(params,current_company)
		contactFormAttribute = @form_attribute.lumniSave(params,current_user)
		lumniClose(@form_attribute,contactFormAttribute)
		@form_template = @form_attribute.form_template
		@field_attributes = @form_template.cached_field_info(current_user,current_company)		
	end

	def edit
		@form_attribute = FormAttribute.lumniStart(params,current_company)
		contactFormAttribute = @form_attribute.lumniSave(params,current_user)
		lumniClose(@form_attribute,contactFormAttribute)
	end

	def update
		@form_attribute = FormAttribute.lumniStart(params,current_company)
		contactFormAttribute = @form_attribute.lumniSave(params,current_user)
		lumniClose(@form_attribute,contactFormAttribute)
		@form_template = @form_attribute.form_template
		@field_attributes = @form_template.cached_field_info(current_user,current_company)		
	end
	def destroy
		@form_attribute = FormAttribute.lumniStart(params,current_company)
		@form_template = @form_attribute.form_field.form_template
		contactFormAttribute = @form_attribute.destroy
		redirect_to edit_form_template_path(@form_template)
		#lumniClose(@cluster,contactFormAttribute)
	end

	def update_value_field
	end
end