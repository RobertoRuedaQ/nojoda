class MercadoPagoResponsesController < ApplicationController
	def index
		@mercado_pago_response = MercadoPagoResponse.lumniStart(params,current_company, list: current_user.template('MercadoPagoResponse','mercado_pago_responses',current_user))
		contactMercadoPagoResponse = @mercado_pago_response.lumniSave(params,current_user, list: current_user.template('MercadoPagoResponse','mercado_pago_responses',current_user))
		lumniClose(@mercado_pago_response,contactMercadoPagoResponse)
	end

	def new
		@mercado_pago_response = MercadoPagoResponse.lumniStart(params,current_company, list: current_user.template('MercadoPagoResponse','mercado_pago_responses',current_user))
		contactMercadoPagoResponse = @mercado_pago_response.lumniSave(params,current_user, list: current_user.template('MercadoPagoResponse','mercado_pago_responses',current_user))
		lumniClose(@mercado_pago_response,contactMercadoPagoResponse)
	end

	def create
		@mercado_pago_response = MercadoPagoResponse.lumniStart(params,current_company, list: current_user.template('MercadoPagoResponse','mercado_pago_responses',current_user))
		contactMercadoPagoResponse = @mercado_pago_response.lumniSave(params,current_user, list: current_user.template('MercadoPagoResponse','mercado_pago_responses',current_user))
		lumniClose(@mercado_pago_response,contactMercadoPagoResponse)
	end

	def edit
		@mercado_pago_response = MercadoPagoResponse.lumniStart(params,current_company, list: current_user.template('MercadoPagoResponse','mercado_pago_responses',current_user))
		contactMercadoPagoResponse = @mercado_pago_response.lumniSave(params,current_user, list: current_user.template('MercadoPagoResponse','mercado_pago_responses',current_user))
		lumniClose(@mercado_pago_response,contactMercadoPagoResponse)
	end

	def update
		@mercado_pago_response = MercadoPagoResponse.lumniStart(params,current_company, list: current_user.template('MercadoPagoResponse','mercado_pago_responses',current_user))
		contactMercadoPagoResponse = @mercado_pago_response.lumniSave(params,current_user, list: current_user.template('MercadoPagoResponse','mercado_pago_responses',current_user))
		lumniClose(@mercado_pago_response,contactMercadoPagoResponse)
	end

	def destroy
		@mercado_pago_response = MercadoPagoResponse.lumniStart(params,current_company, list: current_user.template('MercadoPagoResponse','mercado_pago_responses',current_user))
		contactMercadoPagoResponse = @mercado_pago_response.lumniSave(params,current_user, list: current_user.template('MercadoPagoResponse','mercado_pago_responses',current_user))
		lumniClose(@cluster,contactMercadoPagoResponse)
	end

  def show
		mp_response = MercadoPagoResponse.find_by(external_id: params[:id])
		if mp_response.user.id == current_user.id || current_user.staff?
			@mp_response = mp_response.update_response
		else
			redirect_to root_path
		end
	end


  def sync_payment_confirmation
    if params['transaction_external_id'] == params[:external_reference]
      mp_transaction = MercadoPagoTransaction.find_by_external_id(params[:transaction_external_id])
      ManageMercadoPagoResponseService.for(mp_transaction, params['payment_id'])
      mp_transaction.reload
      redirect_to mercado_pago_response_path(id: mp_transaction.external_id)
    end	
  end


  def async_payment_confirmation
    if params['topic'].present? && params['id'].present?
			PerformMercadoPagoResponseAsync.perform_in(60.seconds, params[:transaction_external_id], params[:id])

      render status: 200, json: {}
    end
  end
end