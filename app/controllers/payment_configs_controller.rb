class PaymentConfigsController < ApplicationController
	def index
		@payment_config = PaymentConfig.lumniStart(params,current_company, list: current_user.template('PaymentConfig','payment_configs',current_user))
		contactPaymentConfig = @payment_config.lumniSave(params,current_user, list: current_user.template('PaymentConfig','payment_configs',current_user))
		lumniClose(@payment_config,contactPaymentConfig)
	end

	def new
		@payment_config = PaymentConfig.lumniStart(params,current_company, list: current_user.template('PaymentConfig','payment_configs',current_user))
		contactPaymentConfig = @payment_config.lumniSave(params,current_user, list: current_user.template('PaymentConfig','payment_configs',current_user))
		lumniClose(@payment_config,contactPaymentConfig)
	end

	def create
		@payment_config = PaymentConfig.lumniStart(params,current_company, list: current_user.template('PaymentConfig','payment_configs',current_user))
		contactPaymentConfig = @payment_config.lumniSave(params,current_user, list: current_user.template('PaymentConfig','payment_configs',current_user))
		lumniClose(@payment_config,contactPaymentConfig)
	end

	def edit
		@payment_config = PaymentConfig.lumniStart(params,current_company, list: current_user.template('PaymentConfig','payment_configs',current_user))
		contactPaymentConfig = @payment_config.lumniSave(params,current_user, list: current_user.template('PaymentConfig','payment_configs',current_user))
		lumniClose(@payment_config,contactPaymentConfig)
	end

	def update
		@payment_config = PaymentConfig.lumniStart(params,current_company, list: current_user.template('PaymentConfig','payment_configs',current_user))
		contactPaymentConfig = @payment_config.lumniSave(params,current_user, list: current_user.template('PaymentConfig','payment_configs',current_user))
		lumniClose(@payment_config,contactPaymentConfig)
	end
	def destroy
		@payment_config = PaymentConfig.lumniStart(params,current_company, list: current_user.template('PaymentConfig','payment_configs',current_user))
		contactPaymentConfig = @payment_config.lumniSave(params,current_user, list: current_user.template('PaymentConfig','payment_configs',current_user))
		lumniClose(@cluster,contactPaymentConfig)
	end
end