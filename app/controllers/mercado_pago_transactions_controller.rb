class MercadoPagoTransactionsController < ApplicationController
	def index
		@mercado_pago_transaction = MercadoPagoTransaction.lumniStart(params,current_company, list: current_user.template('MercadoPagoTransaction','mercado_pago_transactions',current_user))
		contactMercadoPagoTransaction = @mercado_pago_transaction.lumniSave(params,current_user, list: current_user.template('MercadoPagoTransaction','mercado_pago_transactions',current_user))
		lumniClose(@mercado_pago_transaction,contactMercadoPagoTransaction)
	end

	def new
		@mercado_pago_transaction = MercadoPagoTransaction.lumniStart(params,current_company, list: current_user.template('MercadoPagoTransaction','mercado_pago_transactions',current_user))
		contactMercadoPagoTransaction = @mercado_pago_transaction.lumniSave(params,current_user, list: current_user.template('MercadoPagoTransaction','mercado_pago_transactions',current_user))
		lumniClose(@mercado_pago_transaction,contactMercadoPagoTransaction)
	end

	def create
		@mercado_pago_transaction = MercadoPagoTransaction.lumniStart(params,current_company, list: current_user.template('MercadoPagoTransaction','mercado_pago_transactions',current_user))
		contactMercadoPagoTransaction = @mercado_pago_transaction.lumniSave(params,current_user, list: current_user.template('MercadoPagoTransaction','mercado_pago_transactions',current_user))
		lumniClose(@mercado_pago_transaction,contactMercadoPagoTransaction)
	end

	def edit
		@mercado_pago_transaction = MercadoPagoTransaction.lumniStart(params,current_company, list: current_user.template('MercadoPagoTransaction','mercado_pago_transactions',current_user))
		contactMercadoPagoTransaction = @mercado_pago_transaction.lumniSave(params,current_user, list: current_user.template('MercadoPagoTransaction','mercado_pago_transactions',current_user))
		lumniClose(@mercado_pago_transaction,contactMercadoPagoTransaction)
	end

	def update
		@mercado_pago_transaction = MercadoPagoTransaction.lumniStart(params,current_company, list: current_user.template('MercadoPagoTransaction','mercado_pago_transactions',current_user))
		contactMercadoPagoTransaction = @mercado_pago_transaction.lumniSave(params,current_user, list: current_user.template('MercadoPagoTransaction','mercado_pago_transactions',current_user))
		lumniClose(@mercado_pago_transaction,contactMercadoPagoTransaction)
	end
	def destroy
		@mercado_pago_transaction = MercadoPagoTransaction.lumniStart(params,current_company, list: current_user.template('MercadoPagoTransaction','mercado_pago_transactions',current_user))
		contactMercadoPagoTransaction = @mercado_pago_transaction.lumniSave(params,current_user, list: current_user.template('MercadoPagoTransaction','mercado_pago_transactions',current_user))
		lumniClose(@cluster,contactMercadoPagoTransaction)
	end


	def mercado_pago_transaction
		@payment_info = PaymentInfo.new
		@payment_info.build_from_params(params)
		@billing_document = BillingDocument.cached_find(@payment_info.billing_document_id)
		@gateway = @billing_document.gateway
		
		@mp_transaction = @gateway.start_transaction @payment_info, @billing_document, request.remote_ip
		sync_url_notification = "#{request.original_url.split('/')[0]}//#{request.original_url.split('/')[2]}/mercado_pago_responses/sync_payment_confirmation/#{@mp_transaction.external_id}"
		async_url_notification = "#{request.original_url.split('/')[0]}//#{request.original_url.split('/')[2]}/mercado_pago_responses/async_payment_confirmation/#{@mp_transaction.external_id}"
		@preference_id = @gateway.create_preference(@mp_transaction, @billing_document, @payment_info, sync_url_notification, async_url_notification)
		respond_to do |format|
				format.js
		end
	end
end