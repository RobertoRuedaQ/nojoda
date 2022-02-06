class DocsFieldsController < ApplicationController
	def index
		@docs_field = DocsField.lumniStart(params,current_company, list: current_user.template('DocsField','docs_fields',current_user))
		contactDocsField = @docs_field.lumniSave(params,current_user, list: current_user.template('DocsField','docs_fields',current_user))
		lumniClose(@docs_field,contactDocsField)
	end

	def new
		@docs_field = DocsField.lumniStart(params,current_company, list: current_user.template('DocsField','docs_fields',current_user))
		contactDocsField = @docs_field.lumniSave(params,current_user, list: current_user.template('DocsField','docs_fields',current_user))
		lumniClose(@docs_field,contactDocsField)
	end

	def create
		@docs_field = DocsField.lumniStart(params,current_company, list: current_user.template('DocsField','docs_fields',current_user))
		contactDocsField = @docs_field.lumniSave(params,current_user, list: current_user.template('DocsField','docs_fields',current_user))
		lumniClose(@docs_field,contactDocsField)
	end

	def edit
		@docs_field = DocsField.lumniStart(params,current_company, list: current_user.template('DocsField','docs_fields',current_user))
		contactDocsField = @docs_field.lumniSave(params,current_user, list: current_user.template('DocsField','docs_fields',current_user))
		lumniClose(@docs_field,contactDocsField)
	end

	def update
		@docs_field = DocsField.lumniStart(params,current_company, list: current_user.template('DocsField','docs_fields',current_user))
		contactDocsField = @docs_field.lumniSave(params,current_user, list: current_user.template('DocsField','docs_fields',current_user))
		lumniClose(@docs_field,contactDocsField)
	end
	def destroy
		@docs_field = DocsField.lumniStart(params,current_company, list: current_user.template('DocsField','docs_fields',current_user))
		contactDocsField = @docs_field.lumniSave(params,current_user, list: current_user.template('DocsField','docs_fields',current_user))
		lumniClose(@cluster,contactDocsField)
	end
end