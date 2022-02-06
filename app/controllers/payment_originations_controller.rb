class PaymentOriginationsController < ApplicationController
	def index
		@payment_origination = PaymentOrigination.lumniStart(params,current_company, list: current_user.template('PaymentOrigination','payment_originations',current_user))
		contactPaymentOrigination = @payment_origination.lumniSave(params,current_user, list: current_user.template('PaymentOrigination','payment_originations',current_user))
		lumniClose(@payment_origination,contactPaymentOrigination)
	end

	def new
		@payment_origination = PaymentOrigination.lumniStart(params,current_company, list: current_user.template('PaymentOrigination','payment_originations',current_user))
		contactPaymentOrigination = @payment_origination.lumniSave(params,current_user, list: current_user.template('PaymentOrigination','payment_originations',current_user))
		lumniClose(@payment_origination,contactPaymentOrigination)
	end

	def create
		@payment_origination = PaymentOrigination.lumniStart(params,current_company, list: current_user.template('PaymentOrigination','payment_originations',current_user))
		contactPaymentOrigination = @payment_origination.lumniSave(params,current_user, list: current_user.template('PaymentOrigination','payment_originations',current_user))
		lumniClose(@payment_origination,contactPaymentOrigination)
	end

	def edit
		@payment_origination = PaymentOrigination.lumniStart(params,current_company, list: current_user.template('PaymentOrigination','payment_originations',current_user))
		contactPaymentOrigination = @payment_origination.lumniSave(params,current_user, list: current_user.template('PaymentOrigination','payment_originations',current_user))
		lumniClose(@payment_origination,contactPaymentOrigination)
	end

	def update
		@payment_origination = PaymentOrigination.lumniStart(params,current_company, list: current_user.template('PaymentOrigination','payment_originations',current_user))
		contactPaymentOrigination = @payment_origination.lumniSave(params,current_user, list: current_user.template('PaymentOrigination','payment_originations',current_user))
		lumniClose(@payment_origination,contactPaymentOrigination)
	end
	def destroy
		@payment_origination = PaymentOrigination.lumniStart(params,current_company, list: current_user.template('PaymentOrigination','payment_originations',current_user))
		contactPaymentOrigination = @payment_origination.lumniSave(params,current_user, list: current_user.template('PaymentOrigination','payment_originations',current_user))
		lumniClose(@cluster,contactPaymentOrigination)
	end
end