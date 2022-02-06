class WompiResponsesController < ApplicationController
	def index
		@wompi_response = WompiResponse.lumniStart(params,current_company, list: current_user.template('WompiResponse','wompi_responses',current_user))
		contactWompiResponse = @wompi_response.lumniSave(params,current_user, list: current_user.template('WompiResponse','wompi_responses',current_user))
		lumniClose(@wompi_response,contactWompiResponse)
	end

	def new
		@wompi_response = WompiResponse.lumniStart(params,current_company, list: current_user.template('WompiResponse','wompi_responses',current_user))
		contactWompiResponse = @wompi_response.lumniSave(params,current_user, list: current_user.template('WompiResponse','wompi_responses',current_user))
		lumniClose(@wompi_response,contactWompiResponse)
	end

	def create
		@wompi_response = WompiResponse.lumniStart(params,current_company, list: current_user.template('WompiResponse','wompi_responses',current_user))
		contactWompiResponse = @wompi_response.lumniSave(params,current_user, list: current_user.template('WompiResponse','wompi_responses',current_user))
		lumniClose(@wompi_response,contactWompiResponse)
	end

	def edit
		@wompi_response = WompiResponse.lumniStart(params,current_company, list: current_user.template('WompiResponse','wompi_responses',current_user))
		contactWompiResponse = @wompi_response.lumniSave(params,current_user, list: current_user.template('WompiResponse','wompi_responses',current_user))
		lumniClose(@wompi_response,contactWompiResponse)
	end

	def update
		@wompi_response = WompiResponse.lumniStart(params,current_company, list: current_user.template('WompiResponse','wompi_responses',current_user))
		contactWompiResponse = @wompi_response.lumniSave(params,current_user, list: current_user.template('WompiResponse','wompi_responses',current_user))
		lumniClose(@wompi_response,contactWompiResponse)
	end

	def destroy
		@wompi_response = WompiResponse.lumniStart(params,current_company, list: current_user.template('WompiResponse','wompi_responses',current_user))
		contactWompiResponse = @wompi_response.lumniSave(params,current_user, list: current_user.template('WompiResponse','wompi_responses',current_user))
		lumniClose(@cluster,contactWompiResponse)
	end

	def show
		wompi_response = WompiResponse.find_by(payment_id: params[:id])
		if wompi_response.user.id == current_user.id || current_user.staff?
			@wompi_response = wompi_response
		else
			redirect_to root_path
		end
	end

	def async_payment_confirmation
		transaction = WompiTransaction.find_by(wompi_transaction_id: params[:id])
		transaction.get_and_update_from_wompi_service
		
		render status: 200, json: {}
  end

	def sync_payment_confirmation
		transaction = WompiTransaction.find_by(wompi_transaction_id: params[:id])
		transaction.get_and_update_from_wompi_service
		transaction.reload
		redirect_to wompi_response_path(id: transaction.wompi_transaction_id)
  end
end