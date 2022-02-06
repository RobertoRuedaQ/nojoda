class DocsFaqsController < ApplicationController
	def index
		@docs_faq = DocsFaq.lumniStart(params,current_company, list: current_user.template('DocsFaq','docs_faqs',current_user))
		contactDocsFaq = @docs_faq.lumniSave(params,current_user, list: current_user.template('DocsFaq','docs_faqs',current_user))
		lumniClose(@docs_faq,contactDocsFaq)
	end

	def new
		@docs_faq = DocsFaq.lumniStart(params,current_company, list: current_user.template('DocsFaq','docs_faqs',current_user))
		contactDocsFaq = @docs_faq.lumniSave(params,current_user, list: current_user.template('DocsFaq','docs_faqs',current_user))
		lumniClose(@docs_faq,contactDocsFaq)
	end

	def create
		@docs_faq = DocsFaq.lumniStart(params,current_company, list: current_user.template('DocsFaq','docs_faqs',current_user))
		contactDocsFaq = @docs_faq.lumniSave(params,current_user, list: current_user.template('DocsFaq','docs_faqs',current_user))
		lumniClose(@docs_faq,contactDocsFaq)
	end

	def edit
		@docs_faq = DocsFaq.lumniStart(params,current_company, list: current_user.template('DocsFaq','docs_faqs',current_user))
		contactDocsFaq = @docs_faq.lumniSave(params,current_user, list: current_user.template('DocsFaq','docs_faqs',current_user))
		lumniClose(@docs_faq,contactDocsFaq)
	end

	def update
		@docs_faq = DocsFaq.lumniStart(params,current_company, list: current_user.template('DocsFaq','docs_faqs',current_user))
		contactDocsFaq = @docs_faq.lumniSave(params,current_user, list: current_user.template('DocsFaq','docs_faqs',current_user))
		lumniClose(@docs_faq,contactDocsFaq)
	end
	def destroy
		@docs_faq = DocsFaq.lumniStart(params,current_company, list: current_user.template('DocsFaq','docs_faqs',current_user))
		contactDocsFaq = @docs_faq.lumniSave(params,current_user, list: current_user.template('DocsFaq','docs_faqs',current_user))
		lumniClose(@cluster,contactDocsFaq)
	end
end