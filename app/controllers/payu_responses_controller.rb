class PayuResponsesController < ApplicationController
	def index
		@payu_response = PayuResponse.lumniStart(params,current_company, list: current_user.template('PayuResponse','payu_responses',current_user))
		contactPayuResponse = @payu_response.lumniSave(params,current_user, list: current_user.template('PayuResponse','payu_responses',current_user))
		lumniClose(@payu_response,contactPayuResponse)
	end

	def new
		@payu_response = PayuResponse.lumniStart(params,current_company, list: current_user.template('PayuResponse','payu_responses',current_user))
		contactPayuResponse = @payu_response.lumniSave(params,current_user, list: current_user.template('PayuResponse','payu_responses',current_user))
		lumniClose(@payu_response,contactPayuResponse)
	end

	def create
		@payu_response = PayuResponse.lumniStart(params,current_company, list: current_user.template('PayuResponse','payu_responses',current_user))
		contactPayuResponse = @payu_response.lumniSave(params,current_user, list: current_user.template('PayuResponse','payu_responses',current_user))
		lumniClose(@payu_response,contactPayuResponse)
	end

	def edit
		@payu_response = PayuResponse.lumniStart(params,current_company, list: current_user.template('PayuResponse','payu_responses',current_user))
		contactPayuResponse = @payu_response.lumniSave(params,current_user, list: current_user.template('PayuResponse','payu_responses',current_user))
		lumniClose(@payu_response,contactPayuResponse)
	end

	def update
		@payu_response = PayuResponse.lumniStart(params,current_company, list: current_user.template('PayuResponse','payu_responses',current_user))
		contactPayuResponse = @payu_response.lumniSave(params,current_user, list: current_user.template('PayuResponse','payu_responses',current_user))
		lumniClose(@payu_response,contactPayuResponse)
	end
	def destroy
		@payu_response = PayuResponse.lumniStart(params,current_company, list: current_user.template('PayuResponse','payu_responses',current_user))
		contactPayuResponse = @payu_response.lumniSave(params,current_user, list: current_user.template('PayuResponse','payu_responses',current_user))
		lumniClose(@cluster,contactPayuResponse)
	end
	def show
		payu_response = PayuResponse.cached_find(params[:id])
		if payu_response.user.id == current_user.id || current_user.staff?
			@payu_response = payu_response.update_response
		else
			redirect_to root_path
		end
	end


	def transaction_external
		payu_transaction = PayuTransaction.find_by_external_id(params[:id])
		if payu_transaction.payment_method == "WEBCHECKOUT"
			response = payu_transaction.payu_response
			if response.nil?
				response = PayuResponse.create({code: "SUCCESS", order_id: params['reference_pol'], transaction_id: params['transactionId'], 
					state: params['lapTransactionState'], response_code: params['lapResponseCode'],
					trazability_code: params['trazabilityCode'], payu_transaction_id: payu_transaction.id})
			else
				response.update({code: "SUCCESS", order_id: params['reference_pol'], transaction_id: params['transactionId'], 
					state: params['lapTransactionState'], response_code: params['lapResponseCode'],
					trazability_code: params['trazabilityCode'], payu_transaction_id: payu_transaction.id})
			end
		else
			response = payu_transaction.payu_response
		end
		redirect_to response
	end
end














