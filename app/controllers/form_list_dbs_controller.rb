class FormListDbsController < ApplicationController
	def index
		@form_list_db = FormListDb.lumniStart(params,current_company)
		contactFormListDb = @form_list_db.lumniSave(params,current_user)
		lumniClose(@form_list_db,contactFormListDb)
	end

	def new
		@form_list_db = FormListDb.lumniStart(params,current_company)
		contactFormListDb = @form_list_db.lumniSave(params,current_user)
		lumniClose(@form_list_db,contactFormListDb)
	end

	def create
		@form_list_db = FormListDb.lumniStart(params,current_company)
		contactFormListDb = @form_list_db.lumniSave(params,current_user)
		lumniClose(@form_list_db,contactFormListDb)
	end

	def edit
		@form_list_db = FormListDb.lumniStart(params,current_company)
		contactFormListDb = @form_list_db.lumniSave(params,current_user)
		lumniClose(@form_list_db,contactFormListDb)
	end

	def update
		@form_list_db = FormListDb.lumniStart(params,current_company)
		contactFormListDb = @form_list_db.lumniSave(params,current_user)
		lumniClose(@form_list_db,contactFormListDb)
	end
	def destroy
		@form_list_db = FormListDb.lumniStart(params,current_company)
		contactFormListDb = @form_list_db.lumniSave(params,current_user)
		lumniClose(@cluster,contactFormListDb)
	end
end