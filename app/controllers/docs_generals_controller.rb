class DocsGeneralsController < ApplicationController
	def index
		@docs_general = DocsGeneral.lumniStart(params,current_company, list: current_user.template('DocsGeneral','docs_generals',current_user))
		contactDocsGeneral = @docs_general.lumniSave(params,current_user, list: current_user.template('DocsGeneral','docs_generals',current_user))
		lumniClose(@docs_general,contactDocsGeneral)
	end

	def new
		@docs_general = DocsGeneral.lumniStart(params,current_company, list: current_user.template('DocsGeneral','docs_generals',current_user))
		contactDocsGeneral = @docs_general.lumniSave(params,current_user, list: current_user.template('DocsGeneral','docs_generals',current_user))
		lumniClose(@docs_general,contactDocsGeneral)
	end

	def create
		@docs_general = DocsGeneral.lumniStart(params,current_company, list: current_user.template('DocsGeneral','docs_generals',current_user))
		contactDocsGeneral = @docs_general.lumniSave(params,current_user, list: current_user.template('DocsGeneral','docs_generals',current_user))
		lumniClose(@docs_general,contactDocsGeneral)
	end

	def edit
		@docs_general = DocsGeneral.lumniStart(params,current_company, list: current_user.template('DocsGeneral','docs_generals',current_user))
		contactDocsGeneral = @docs_general.lumniSave(params,current_user, list: current_user.template('DocsGeneral','docs_generals',current_user))
		lumniClose(@docs_general,contactDocsGeneral)
	end

	def update
		@docs_general = DocsGeneral.lumniStart(params,current_company, list: current_user.template('DocsGeneral','docs_generals',current_user))
		contactDocsGeneral = @docs_general.lumniSave(params,current_user, list: current_user.template('DocsGeneral','docs_generals',current_user))
		lumniClose(@docs_general,contactDocsGeneral)
	end
	def destroy
		@docs_general = DocsGeneral.lumniStart(params,current_company, list: current_user.template('DocsGeneral','docs_generals',current_user))
		contactDocsGeneral = @docs_general.lumniSave(params,current_user, list: current_user.template('DocsGeneral','docs_generals',current_user))
		lumniClose(@cluster,contactDocsGeneral)
	end

	def documentation
		@general_docs = DocsGeneral.where(controller: params[:target_controller],language: current_user.language).first
		if @general_docs.nil?
			@general_docs = DocsGeneral.where(controller: params[:target_controller]).first

			if @general_docs.nil?
				@general_docs = DocsGeneral.create({controller: params[:target_controller], language: current_user.language})
			end
		end
	end

end