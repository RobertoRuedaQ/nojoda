class BillingDocumentDetailsController < ApplicationController
	def index
		@billing_document_detail = BillingDocumentDetail.lumniStart(params,current_company, list: current_user.template('BillingDocumentDetail','billing_document_details',current_user))
		contactBillingDocumentDetail = @billing_document_detail.lumniSave(params,current_user, list: current_user.template('BillingDocumentDetail','billing_document_details',current_user))
		lumniClose(@billing_document_detail,contactBillingDocumentDetail)
	end

	def new
		@billing_document_detail = BillingDocumentDetail.lumniStart(params,current_company, list: current_user.template('BillingDocumentDetail','billing_document_details',current_user))
		contactBillingDocumentDetail = @billing_document_detail.lumniSave(params,current_user, list: current_user.template('BillingDocumentDetail','billing_document_details',current_user))
		lumniClose(@billing_document_detail,contactBillingDocumentDetail)
	end

	def create
		@billing_document_detail = BillingDocumentDetail.lumniStart(params,current_company, list: current_user.template('BillingDocumentDetail','billing_document_details',current_user))
		contactBillingDocumentDetail = @billing_document_detail.lumniSave(params,current_user, list: current_user.template('BillingDocumentDetail','billing_document_details',current_user))
		lumniClose(@billing_document_detail,contactBillingDocumentDetail)
	end

	def edit
		@billing_document_detail = BillingDocumentDetail.includes([:payment_match]).lumniStart(params,current_company, list: current_user.template('BillingDocumentDetail','billing_document_details',current_user))
		contactBillingDocumentDetail = @billing_document_detail.lumniSave(params,current_user, list: current_user.template('BillingDocumentDetail','billing_document_details',current_user))
		lumniClose(@billing_document_detail,contactBillingDocumentDetail)
	end

	def update
		@billing_document_detail = BillingDocumentDetail.lumniStart(params,current_company, list: current_user.template('BillingDocumentDetail','billing_document_details',current_user))
		contactBillingDocumentDetail = @billing_document_detail.lumniSave(params,current_user, list: current_user.template('BillingDocumentDetail','billing_document_details',current_user))
		lumniClose(@billing_document_detail,contactBillingDocumentDetail)
	end
	def destroy
		@billing_document_detail = BillingDocumentDetail.lumniStart(params,current_company, list: current_user.template('BillingDocumentDetail','billing_document_details',current_user))
		contactBillingDocumentDetail = @billing_document_detail.lumniSave(params,current_user, list: current_user.template('BillingDocumentDetail','billing_document_details',current_user))
		lumniClose(@cluster,contactBillingDocumentDetail)
	end
end