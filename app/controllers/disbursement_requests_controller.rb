class DisbursementRequestsController < ApplicationController
	def index
		@disbursement_request = DisbursementRequest.lumniStart(params,current_company, list: current_user.template('DisbursementRequest','disbursement_requests',current_user))
		contactDisbursementRequest = @disbursement_request.lumniSave(params,current_user, list: current_user.template('DisbursementRequest','disbursement_requests',current_user))
		lumniClose(@disbursement_request,contactDisbursementRequest)
	end

	def new
		@disbursement_request = DisbursementRequest.lumniStart(params,current_company, list: current_user.template('DisbursementRequest','disbursement_requests',current_user))
		contactDisbursementRequest = @disbursement_request.lumniSave(params,current_user, list: current_user.template('DisbursementRequest','disbursement_requests',current_user))
		lumniClose(@disbursement_request,contactDisbursementRequest)
	end

	def create
		@disbursement_request = DisbursementRequest.lumniStart(params,current_company, list: current_user.template('DisbursementRequest','disbursement_requests',current_user))
		contactDisbursementRequest = @disbursement_request.lumniSave(params,current_user, list: current_user.template('DisbursementRequest','disbursement_requests',current_user))
		lumniClose(@disbursement_request,contactDisbursementRequest)
	end

	def edit
		@disbursement_request = DisbursementRequest.lumniStart(params,current_company, list: current_user.template('DisbursementRequest','disbursement_requests',current_user))
		contactDisbursementRequest = @disbursement_request.lumniSave(params,current_user, list: current_user.template('DisbursementRequest','disbursement_requests',current_user))
		lumniClose(@disbursement_request,contactDisbursementRequest)
	end

	def update
		@disbursement_request = DisbursementRequest.find(params[:id])
		@disbursement_request.attributes = disbursement_request_params
		request = current_user.request_for_update(@disbursement_request,reason: 'se necesitan cambia solicitud')
		if request.save
			@disbursement_request.flush_commit_cache
			flash[:success] = I18n.t('flash.disbursement_request_updated')
		else
			flash[:danger] = I18n.t('flash.record_failed')
		end
		redirect_to edit_disbursement_request_path(@disbursement_request)
	end

	def destroy
		@disbursement_request = DisbursementRequest.lumniStart(params,current_company, list: current_user.template('DisbursementRequest','disbursement_requests',current_user))
		contactDisbursementRequest = @disbursement_request.lumniSave(params,current_user, list: current_user.template('DisbursementRequest','disbursement_requests',current_user))
		lumniClose(@cluster,contactDisbursementRequest)
	end

	def send_disbursement_request
		application = Application.cached_find(params[:id])
		application.update(status: 'submitted')
		redirect_to edit_application_path(application)
	end

	def request_disbursement
		disbursement = Disbursement.cached_find(params[:id])
		if valid_to_date?(disbursement) 
			application = Application.new({status: 'active',user_id: current_user.id,application_case: 'disbursement_request',resource_type: 'Disbursement', resource_id: disbursement.id})
			if application.save
				case disbursement.disbursement_case
				when 'tuition'
					questionnaire = disbursement.questionnaire_tuition
				when 'living_expenses'
					questionnaire = disbursement.questionnaire_living_expenses
				when 'emergency_living_expenses'
					questionnaire = disbursement.questionnaire_living_expenses
				end
				disbursement.update(status: 'requesting')
				redirect_to edit_application_path(application)
			else
				redirect_to root_path
			end
		else
			flash[:danger] = I18n.t('flash.no_available_for_disbursement')
			redirect_to disbursement_mains_path
		end

	end

	private

	def valid_to_date?(disbursement)
		isa = disbursement.user.active_isa.first
		isa.stored_payment_status == 'up_to_date'
	end

	def disbursement_request_params
		params.require('disbursementrequest').permit(@disbursement_request.attributes.keys)
	end
end



