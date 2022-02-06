class PaymentAgreementsController < ApplicationController
	include LumniFinance
	def index
		@payment_agreement = PaymentAgreement.lumniStart(params,current_company, list: current_user.template('PaymentAgreement','payment_agreements',current_user))
		contactPaymentAgreement = @payment_agreement.lumniSave(params,current_user, list: current_user.template('PaymentAgreement','payment_agreements',current_user))
		lumniClose(@payment_agreement,contactPaymentAgreement)
	end

	def new
		@payment_agreement = PaymentAgreement.lumniStart(params,current_company, list: current_user.template('PaymentAgreement','payment_agreements',current_user))
		contactPaymentAgreement = @payment_agreement.lumniSave(params,current_user, list: current_user.template('PaymentAgreement','payment_agreements',current_user))
		lumniClose(@payment_agreement,contactPaymentAgreement)
	end

	def create
		@payment_agreement = PaymentAgreement.lumniStart(params,current_company, list: current_user.template('PaymentAgreement','payment_agreements',current_user))
		contactPaymentAgreement = @payment_agreement.lumniSave(params,current_user, list: current_user.template('PaymentAgreement','payment_agreements',current_user))
		@payment_agreement.billing_document.refresh
		redirect_to edit_student_path(@payment_agreement.isa.user_id)
	end

	def edit
		@payment_agreement = PaymentAgreement.lumniStart(params,current_company, list: current_user.template('PaymentAgreement','payment_agreements',current_user))
		contactPaymentAgreement = @payment_agreement.lumniSave(params,current_user, list: current_user.template('PaymentAgreement','payment_agreements',current_user))
		lumniClose(@payment_agreement,contactPaymentAgreement)
	end

	def update
		@payment_agreement = PaymentAgreement.lumniStart(params,current_company, list: current_user.template('PaymentAgreement','payment_agreements',current_user))
		contactPaymentAgreement = @payment_agreement.lumniSave(params,current_user, list: current_user.template('PaymentAgreement','payment_agreements',current_user))
		@payment_agreement.billing_document.refresh
		redirect_to edit_student_path(@payment_agreement.isa.user_id)
	end
	def destroy
		@payment_agreement = PaymentAgreement.lumniStart(params,current_company, list: current_user.template('PaymentAgreement','payment_agreements',current_user))
		contactPaymentAgreement = @payment_agreement.lumniSave(params,current_user, list: current_user.template('PaymentAgreement','payment_agreements',current_user))
		lumniClose(@cluster,contactPaymentAgreement)
	end

	def simulate
		@rate = params[:paymentagreement_rate]
		@start_date = params[:paymentagreement_start_date]
		@number_payments = params[:paymentagreement_number_payments]
		@value = params[:paymentagreement_value]
		@estimation_date = Time.now.to_date

		@amortization_payment = amortization_payment(@value,@rate,@number_payments, @estimation_date, @start_date)
		
	end
end