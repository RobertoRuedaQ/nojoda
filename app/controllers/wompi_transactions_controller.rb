class WompiTransactionsController < ApplicationController

	def index
		@wompi_transaction = WompiTransaction.lumniStart(params,current_company, list: current_user.template('WompiTransaction','wompi_transactions',current_user))
		contactWompiTransaction = @wompi_transaction.lumniSave(params,current_user, list: current_user.template('WompiTransaction','wompi_transactions',current_user))
		lumniClose(@wompi_transaction,contactWompiTransaction)
	end

	def new
		@wompi_transaction = WompiTransaction.lumniStart(params,current_company, list: current_user.template('WompiTransaction','wompi_transactions',current_user))
		contactWompiTransaction = @wompi_transaction.lumniSave(params,current_user, list: current_user.template('WompiTransaction','wompi_transactions',current_user))
		lumniClose(@wompi_transaction,contactWompiTransaction)
	end

	def create
		@wompi_transaction = WompiTransaction.lumniStart(params,current_company, list: current_user.template('WompiTransaction','wompi_transactions',current_user))
		contactWompiTransaction = @wompi_transaction.lumniSave(params,current_user, list: current_user.template('WompiTransaction','wompi_transactions',current_user))
		lumniClose(@wompi_transaction,contactWompiTransaction)
	end

	def edit
		@wompi_transaction = WompiTransaction.lumniStart(params,current_company, list: current_user.template('WompiTransaction','wompi_transactions',current_user))
		contactWompiTransaction = @wompi_transaction.lumniSave(params,current_user, list: current_user.template('WompiTransaction','wompi_transactions',current_user))
		lumniClose(@wompi_transaction,contactWompiTransaction)
	end

	def update
		@wompi_transaction = WompiTransaction.lumniStart(params,current_company, list: current_user.template('WompiTransaction','wompi_transactions',current_user))
		contactWompiTransaction = @wompi_transaction.lumniSave(params,current_user, list: current_user.template('WompiTransaction','wompi_transactions',current_user))
		lumniClose(@wompi_transaction,contactWompiTransaction)
	end
	def destroy
		@wompi_transaction = WompiTransaction.lumniStart(params,current_company, list: current_user.template('WompiTransaction','wompi_transactions',current_user))
		contactWompiTransaction = @wompi_transaction.lumniSave(params,current_user, list: current_user.template('WompiTransaction','wompi_transactions',current_user))
		lumniClose(@cluster,contactWompiTransaction)
	end

	def cash_payment_info
		@data_to_pay = data_to_pay
	end

	def wompi_transaction
		@payment_info = PaymentInfo.new
		@payment_info.build_from_params(params)

		@billing_document = BillingDocument.cached_find(@payment_info.billing_document_id)

		@gateway = if @billing_document.gateway.instance_of?(WompiGateway)
			@billing_document.gateway
		else
			@billing_document.isa.funding_opportunity.fund.wompi_gateway
		end
		
		if @payment_info.payment_method == 'BANCOLOMBIA_COLLECT'
			@data_to_pay = {
				agreement_code: @gateway.agreement_code,
				student_identification_number: @billing_document.user.identification_number
			}
			render action: 'cash_payment_info', locals: { data_to_pay: @data_to_pay }
		else
			
			begin
				@wompi_transaction = @gateway.start_transaction(@payment_info, @billing_document, request.remote_ip, @gateway)
				@sync_url_notification = "#{request.original_url.split('/')[0]}//#{request.original_url.split('/')[2]}/wompi_responses/sync_payment_confirmation/#{@wompi_transaction.external_id}"
				@pse_transaction = @gateway.get_wompi_transaction(@payment_info, @billing_document, @wompi_transaction, @sync_url_notification)
				@wompi_transaction.update(wompi_transaction_id: @pse_transaction['id'])
				case @wompi_transaction.payment_method
				when 'PSE'
					url_transaction = ''
					transaction = ''
					until url_transaction.present? || transaction['status'] == 'ERROR'
						transaction = @gateway.find_wompi_transaction_by_id(@wompi_transaction.wompi_transaction_id)
						if transaction['payment_method']['extra'].present?
							url_transaction = transaction['payment_method']['extra']['async_payment_url']
						end
					end

					redirect_to url_transaction
				when ''
				end
			end
		end
	end
end