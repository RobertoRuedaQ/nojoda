class DisbursementPaymentsController < ApplicationController
	def index
		@disbursement_payment = DisbursementPayment.account_payments
		contactDisbursementPayment = @disbursement_payment.lumniSave(params,current_user, list: current_user.template('DisbursementPayment','disbursement_payments',current_user))
		lumniClose(@disbursement_payment,contactDisbursementPayment)

	end

	def new
		@disbursement_payment = DisbursementPayment.lumniStart(params,current_company, list: current_user.template('DisbursementPayment','disbursement_payments',current_user))
		contactDisbursementPayment = @disbursement_payment.lumniSave(params,current_user, list: current_user.template('DisbursementPayment','disbursement_payments',current_user))
		lumniClose(@disbursement_payment,contactDisbursementPayment)
	end

	def create
		@disbursement_payment = DisbursementPayment.lumniStart(params,current_company, list: current_user.template('DisbursementPayment','disbursement_payments',current_user))
		contactDisbursementPayment = @disbursement_payment.lumniSave(params,current_user, list: current_user.template('DisbursementPayment','disbursement_payments',current_user))
		redirect_to edit_disbursement_path(@disbursement_payment.disbursement_id)
	end

	def edit
		@disbursement_payment = DisbursementPayment.lumniStart(params,current_company, list: current_user.template('DisbursementPayment','disbursement_payments',current_user))
		contactDisbursementPayment = @disbursement_payment.lumniSave(params,current_user, list: current_user.template('DisbursementPayment','disbursement_payments',current_user))
		lumniClose(@disbursement_payment,contactDisbursementPayment)
	end

	def update
		@disbursement_payment = DisbursementPayment.lumniStart(params,current_company, list: current_user.template('DisbursementPayment','disbursement_payments',current_user))
		contactDisbursementPayment = @disbursement_payment.lumniSave(params,current_user, list: current_user.template('DisbursementPayment','disbursement_payments',current_user))
		redirect_to edit_disbursement_path(@disbursement_payment.disbursement_id)
	end
	def destroy
		@disbursement_payment = DisbursementPayment.lumniStart(params,current_company, list: current_user.template('DisbursementPayment','disbursement_payments',current_user))
		contactDisbursementPayment = @disbursement_payment.lumniSave(params,current_user, list: current_user.template('DisbursementPayment','disbursement_payments',current_user))
		lumniClose(@cluster,contactDisbursementPayment)
	end
end