class ModelAndFieldsController < ApplicationController
	include LumniLanguage
	include LumniDataStructureInformation
	def index
		@header = ['model','field']
		@header += languageList[:language][:values]
		@rows = []

		models_list.each do |target_model|

			begin

				eval("#{target_model}.full_field_names").each do |field|
					temp_row = [target_model,field]
					languageList[:language][:values].each do |language|
						I18n.locale = language
						temp_row += [eval("#{target_model}.human_attribute_name('#{field}')")]
					end
					@rows += [temp_row]
				end
				
			rescue Exception => e
				
			end

		end

		@model_and_field = ModelAndField.lumniStart(params,current_company, list: current_user.template('ModelAndField','model_and_fields',current_user))
		contactModelAndField = @model_and_field.lumniSave(params,current_user, list: current_user.template('ModelAndField','model_and_fields',current_user))
		lumniClose(@model_and_field,contactModelAndField)
	end

	def new
		@model_and_field = ModelAndField.lumniStart(params,current_company, list: current_user.template('ModelAndField','model_and_fields',current_user))
		contactModelAndField = @model_and_field.lumniSave(params,current_user, list: current_user.template('ModelAndField','model_and_fields',current_user))
		lumniClose(@model_and_field,contactModelAndField)
	end

	def create
		@model_and_field = ModelAndField.lumniStart(params,current_company, list: current_user.template('ModelAndField','model_and_fields',current_user))
		contactModelAndField = @model_and_field.lumniSave(params,current_user, list: current_user.template('ModelAndField','model_and_fields',current_user))
		lumniClose(@model_and_field,contactModelAndField)
	end

	def edit
		@model_and_field = ModelAndField.lumniStart(params,current_company, list: current_user.template('ModelAndField','model_and_fields',current_user))
		contactModelAndField = @model_and_field.lumniSave(params,current_user, list: current_user.template('ModelAndField','model_and_fields',current_user))
		lumniClose(@model_and_field,contactModelAndField)
	end

	def update
		@model_and_field = ModelAndField.lumniStart(params,current_company, list: current_user.template('ModelAndField','model_and_fields',current_user))
		contactModelAndField = @model_and_field.lumniSave(params,current_user, list: current_user.template('ModelAndField','model_and_fields',current_user))
		lumniClose(@model_and_field,contactModelAndField)
	end
	def destroy
		@model_and_field = ModelAndField.lumniStart(params,current_company, list: current_user.template('ModelAndField','model_and_fields',current_user))
		contactModelAndField = @model_and_field.lumniSave(params,current_user, list: current_user.template('ModelAndField','model_and_fields',current_user))
		lumniClose(@cluster,contactModelAndField)
	end
end