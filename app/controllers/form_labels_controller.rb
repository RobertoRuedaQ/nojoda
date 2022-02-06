class FormLabelsController < ApplicationController
	def index
		@form_label = FormLabel.lumniStart(params,current_company)
		contactFormLabel = @form_label.lumniSave(params,current_user)
		lumniClose(@form_label,contactFormLabel)
	end

	def new
		@form_label = FormLabel.lumniStart(params,current_company)
		contactFormLabel = @form_label.lumniSave(params,current_user)
		lumniClose(@form_label,contactFormLabel)
	end

	def create
		@form_label = FormLabel.lumniStart(params,current_company)
		contactFormLabel = @form_label.lumniSave(params,current_user)
		lumniClose(@form_label,contactFormLabel)

		if @form_label.resource_type == 'FormList'
			@form_list = @form_label.resource
		elsif @form_label.resource_type == 'FormValue'
			@form_value = @form_label.resource
		end
	end

	def edit
		@form_label = FormLabel.lumniStart(params,current_company)
		contactFormLabel = @form_label.lumniSave(params,current_user)
		lumniClose(@form_label,contactFormLabel)
	end

	def update
		@form_label = FormLabel.lumniStart(params,current_company)
		contactFormLabel = @form_label.lumniSave(params,current_user)
		lumniClose(@form_label,contactFormLabel)
	end
	def destroy
		@form_label = FormLabel.lumniStart(params,current_company)
		contactFormLabel = @form_label.lumniSave(params,current_user)
		lumniClose(@cluster,contactFormLabel)
	end
	def create_label
		@form_label = FormLabel.new({language: params[:language],resource_id: params[:form_list_value_id],resource_type: 'FormListValue'})
	end

	def update_label
		@form_label = FormLabel.cached_find(params[:id])
	end
end