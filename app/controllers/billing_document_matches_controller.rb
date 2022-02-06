class BillingDocumentMatchesController < ApplicationController
	def index
		@billing_document_match = BillingDocumentMatch.lumniStart(params,current_company, list: current_user.template('BillingDocumentMatch','billing_document_matches',current_user))
		contactBillingDocumentMatch = @billing_document_match.lumniSave(params,current_user, list: current_user.template('BillingDocumentMatch','billing_document_matches',current_user))
		lumniClose(@billing_document_match,contactBillingDocumentMatch)
	end

	def new
		@billing_document_match = BillingDocumentMatch.lumniStart(params,current_company, list: current_user.template('BillingDocumentMatch','billing_document_matches',current_user))
		contactBillingDocumentMatch = @billing_document_match.lumniSave(params,current_user, list: current_user.template('BillingDocumentMatch','billing_document_matches',current_user))
		lumniClose(@billing_document_match,contactBillingDocumentMatch)
	end

	def create
		@billing_document_match = BillingDocumentMatch.lumniStart(params,current_company, list: current_user.template('BillingDocumentMatch','billing_document_matches',current_user))
		contactBillingDocumentMatch = @billing_document_match.lumniSave(params,current_user, list: current_user.template('BillingDocumentMatch','billing_document_matches',current_user))
		lumniClose(@billing_document_match,contactBillingDocumentMatch)
	end

	def edit
		@billing_document_match = BillingDocumentMatch.lumniStart(params,current_company, list: current_user.template('BillingDocumentMatch','billing_document_matches',current_user))
		contactBillingDocumentMatch = @billing_document_match.lumniSave(params,current_user, list: current_user.template('BillingDocumentMatch','billing_document_matches',current_user))
		lumniClose(@billing_document_match,contactBillingDocumentMatch)
	end

	def update
		@billing_document_match = BillingDocumentMatch.lumniStart(params,current_company, list: current_user.template('BillingDocumentMatch','billing_document_matches',current_user))
		contactBillingDocumentMatch = @billing_document_match.lumniSave(params,current_user, list: current_user.template('BillingDocumentMatch','billing_document_matches',current_user))
		lumniClose(@billing_document_match,contactBillingDocumentMatch)
	end
	def destroy
		@billing_document_match = BillingDocumentMatch.lumniStart(params,current_company, list: current_user.template('BillingDocumentMatch','billing_document_matches',current_user))
		contactBillingDocumentMatch = @billing_document_match.lumniSave(params,current_user, list: current_user.template('BillingDocumentMatch','billing_document_matches',current_user))
		lumniClose(@cluster,contactBillingDocumentMatch)
	end
end