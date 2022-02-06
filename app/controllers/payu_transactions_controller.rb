class PayuTransactionsController < ApplicationController
	def index
		@payu_transaction = PayuTransaction.lumniStart(params,current_company, list: current_user.template('PayuTransaction','payu_transactions',current_user))
		contactPayuTransaction = @payu_transaction.lumniSave(params,current_user, list: current_user.template('PayuTransaction','payu_transactions',current_user))
		lumniClose(@payu_transaction,contactPayuTransaction)
	end

	def new
		@payu_transaction = PayuTransaction.lumniStart(params,current_company, list: current_user.template('PayuTransaction','payu_transactions',current_user))
		contactPayuTransaction = @payu_transaction.lumniSave(params,current_user, list: current_user.template('PayuTransaction','payu_transactions',current_user))
		lumniClose(@payu_transaction,contactPayuTransaction)
	end

	def create
		@payu_transaction = PayuTransaction.lumniStart(params,current_company, list: current_user.template('PayuTransaction','payu_transactions',current_user))
		contactPayuTransaction = @payu_transaction.lumniSave(params,current_user, list: current_user.template('PayuTransaction','payu_transactions',current_user))
		lumniClose(@payu_transaction,contactPayuTransaction)
	end

	def edit
		@payu_transaction = PayuTransaction.lumniStart(params,current_company, list: current_user.template('PayuTransaction','payu_transactions',current_user))
		contactPayuTransaction = @payu_transaction.lumniSave(params,current_user, list: current_user.template('PayuTransaction','payu_transactions',current_user))
		lumniClose(@payu_transaction,contactPayuTransaction)
	end

	def update
		@payu_transaction = PayuTransaction.lumniStart(params,current_company, list: current_user.template('PayuTransaction','payu_transactions',current_user))
		contactPayuTransaction = @payu_transaction.lumniSave(params,current_user, list: current_user.template('PayuTransaction','payu_transactions',current_user))
		lumniClose(@payu_transaction,contactPayuTransaction)
	end
	def destroy
		@payu_transaction = PayuTransaction.lumniStart(params,current_company, list: current_user.template('PayuTransaction','payu_transactions',current_user))
		contactPayuTransaction = @payu_transaction.lumniSave(params,current_user, list: current_user.template('PayuTransaction','payu_transactions',current_user))
		lumniClose(@cluster,contactPayuTransaction)
	end

	def payu_transaction

		@payment_info = PaymentInfo.new
		@payment_info.build_from_params(params)
		@billing_document = BillingDocument.cached_find(@payment_info.billing_document_id)
		@gateway = @billing_document.gateway
		begin
			@payu_transaction = @gateway.start_transaction @payment_info, @billing_document, request.remote_ip

			case @payu_transaction.payment_method
			when *@gateway.cash_methods
				@payu_response = @gateway.cash_response @payu_transaction,@billing_document,"#{request.original_url.split('/')[0]}//#{request.original_url.split('/')[2]}/payu_confirmations/#{@payu_transaction.external_id}/payu_confirmation" , @payment_info
				if !@payu_response.target_redirect.nil?
					redirect_to @payu_response.target_redirect
				else
					flash[:danger] = @payu_response['error']
				end
			when *@gateway.cards_methods
				@payu_response = @gateway.card_response @payu_transaction,@billing_document,"#{request.original_url.split('/')[0]}//#{request.original_url.split('/')[2]}/payu_confirmations/#{@payu_transaction.external_id}/payu_confirmation" ,@payment_info
				redirect_to @payu_response
			when 'SPEI'
				@payu_response = @gateway.spei_request @payu_transaction,@billing_document,"#{request.original_url.split('/')[0]}//#{request.original_url.split('/')[2]}/payu_confirmations/#{@payu_transaction.external_id}/payu_confirmation" ,@payment_info
				if !@payu_response.target_redirect.nil?
					redirect_to @payu_response.target_redirect
				else
					flash[:danger] = @payu_response['error']
				end
			when 'TRANSBANK_DEBIT'
				@payu_response = @gateway.redcompra_request @payu_transaction,@billing_document,"#{request.original_url.split('/')[0]}//#{request.original_url.split('/')[2]}/payu_confirmations/#{@payu_transaction.external_id}/payu_confirmation" ,@payment_info
				if !@payu_response.target_redirect.nil?
					redirect_to @payu_response.target_redirect
				else
					flash[:danger] = @payu_response['error']
				end
				
			when 'PSE'
				@payu_response = @gateway.pse_request @payu_transaction,@billing_document,"#{request.original_url.split('/')[0]}//#{request.original_url.split('/')[2]}/payu_confirmations/#{@payu_transaction.external_id}/payu_confirmation", "#{request.original_url.split('/')[0]}//#{request.original_url.split('/')[2]}/payu_responses/#{@payu_transaction.external_id}/transaction_external" ,@payment_info
				if ["PENDING","APPROVED"].include?(@payu_response.state)
					redirect_to @payu_response.target_redirect
				else
					flash[:danger] = I18n.t("payu.response_code_transaction.#{@payu_response.state}")
					redirect_to @billing_document
				end
			end			
			
		rescue Exception => e

				flash[:danger] = I18n.t("payu.response_code_transaction.payu_general_error")
				redirect_to @billing_document
		end

	end

end