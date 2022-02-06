class PaymentExcessesController < ApplicationController
	def index
		@payment_excess = PaymentExcess.lumniStart(params,current_company, list: current_user.template('PaymentExcess','payment_excesses',current_user))
		contactPaymentExcess = @payment_excess.lumniSave(params,current_user, list: current_user.template('PaymentExcess','payment_excesses',current_user))
		lumniClose(@payment_excess,contactPaymentExcess)
	end

	def new
		@payment_excess = PaymentExcess.lumniStart(params,current_company, list: current_user.template('PaymentExcess','payment_excesses',current_user))
		contactPaymentExcess = @payment_excess.lumniSave(params,current_user, list: current_user.template('PaymentExcess','payment_excesses',current_user))
		lumniClose(@payment_excess,contactPaymentExcess)
	end

	def create
		@payment_excess = PaymentExcess.lumniStart(params,current_company, list: current_user.template('PaymentExcess','payment_excesses',current_user))
		contactPaymentExcess = @payment_excess.lumniSave(params,current_user, list: current_user.template('PaymentExcess','payment_excesses',current_user))
		lumniClose(@payment_excess,contactPaymentExcess)
	end

	def edit
		@payment_excess = PaymentExcess.lumniStart(params,current_company, list: current_user.template('PaymentExcess','payment_excesses',current_user))
		contactPaymentExcess = @payment_excess.lumniSave(params,current_user, list: current_user.template('PaymentExcess','payment_excesses',current_user))
		lumniClose(@payment_excess,contactPaymentExcess)
	end

	def update
		@payment_excess = PaymentExcess.lumniStart(params,current_company, list: current_user.template('PaymentExcess','payment_excesses',current_user))
		contactPaymentExcess = @payment_excess.lumniSave(params,current_user, list: current_user.template('PaymentExcess','payment_excesses',current_user))
		lumniClose(@payment_excess,contactPaymentExcess)
	end
	def destroy
		@payment_excess = PaymentExcess.lumniStart(params,current_company, list: current_user.template('PaymentExcess','payment_excesses',current_user))
		contactPaymentExcess = @payment_excess.lumniSave(params,current_user, list: current_user.template('PaymentExcess','payment_excesses',current_user))
		lumniClose(@cluster,contactPaymentExcess)
	end
end