class PaymentMatchesController < ApplicationController
	def index
		if billing_document_detail_id
			@detail = BillingDocumentDetail.find(billing_document_detail_id)
			@payment_matches = @detail.payment_match.includes(:payment)
			render 'show_payment_matches_for_detail'
		else
			@payment_match = PaymentMatch.lumniStart(params,current_company, list: current_user.template('PaymentMatch','payment_matches',current_user))
			contactPaymentMatch = @payment_match.lumniSave(params,current_user, list: current_user.template('PaymentMatch','payment_matches',current_user))
			lumniClose(@payment_match,contactPaymentMatch)
		end
	end

	def new
		@payment_match = PaymentMatch.lumniStart(params,current_company, list: current_user.template('PaymentMatch','payment_matches',current_user))
		contactPaymentMatch = @payment_match.lumniSave(params,current_user, list: current_user.template('PaymentMatch','payment_matches',current_user))
		lumniClose(@payment_match,contactPaymentMatch)
	end

	def create
		@payment_match = PaymentMatch.lumniStart(params,current_company, list: current_user.template('PaymentMatch','payment_matches',current_user))
		contactPaymentMatch = @payment_match.lumniSave(params,current_user, list: current_user.template('PaymentMatch','payment_matches',current_user))
		lumniClose(@payment_match,contactPaymentMatch)
	end

	def edit
		@payment_match = PaymentMatch.lumniStart(params,current_company, list: current_user.template('PaymentMatch','payment_matches',current_user))
		contactPaymentMatch = @payment_match.lumniSave(params,current_user, list: current_user.template('PaymentMatch','payment_matches',current_user))
		lumniClose(@payment_match,contactPaymentMatch)
	end

	def update
		@payment_match = PaymentMatch.lumniStart(params,current_company, list: current_user.template('PaymentMatch','payment_matches',current_user))
		contactPaymentMatch = @payment_match.lumniSave(params,current_user, list: current_user.template('PaymentMatch','payment_matches',current_user))
		lumniClose(@payment_match,contactPaymentMatch)
	end
	def destroy
		@payment_match = PaymentMatch.lumniStart(params,current_company, list: current_user.template('PaymentMatch','payment_matches',current_user))
		contactPaymentMatch = @payment_match.lumniSave(params,current_user, list: current_user.template('PaymentMatch','payment_matches',current_user))
		lumniClose(@cluster,contactPaymentMatch)
	end


	private

	def billing_document_detail_id
		params['billing_document_detail_id']
	end
end