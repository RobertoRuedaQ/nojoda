class CancellationRequestsController < ApplicationController
	def index
		@cancellation_request = CancellationRequest.lumniStart(params,current_company, list: current_user.template('CancellationRequest','cancellation_requests',current_user))
		contactCancellationRequest = @cancellation_request.lumniSave(params,current_user, list: current_user.template('CancellationRequest','cancellation_requests',current_user))
		lumniClose(@cancellation_request,contactCancellationRequest)
	end

	def new
		@cancellation_request = CancellationRequest.lumniStart(params,current_company, list: current_user.template('CancellationRequest','cancellation_requests',current_user))
		contactCancellationRequest = @cancellation_request.lumniSave(params,current_user, list: current_user.template('CancellationRequest','cancellation_requests',current_user))
		lumniClose(@cancellation_request,contactCancellationRequest)
	end

	def create
		@cancellation_request = CancellationRequest.lumniStart(params,current_company, list: current_user.template('CancellationRequest','cancellation_requests',current_user))
		contactCancellationRequest = @cancellation_request.lumniSave(params,current_user, list: current_user.template('CancellationRequest','cancellation_requests',current_user))
		lumniClose(@cancellation_request,contactCancellationRequest)
	end

	def edit
		@cancellation_request = CancellationRequest.lumniStart(params,current_company, list: current_user.template('CancellationRequest','cancellation_requests',current_user))
		contactCancellationRequest = @cancellation_request.lumniSave(params,current_user, list: current_user.template('CancellationRequest','cancellation_requests',current_user))
		lumniClose(@cancellation_request,contactCancellationRequest)
	end

	def update
		@cancellation_request = CancellationRequest.lumniStart(params,current_company, list: current_user.template('CancellationRequest','cancellation_requests',current_user))
		contactCancellationRequest = @cancellation_request.lumniSave(params,current_user, list: current_user.template('CancellationRequest','cancellation_requests',current_user))
		lumniClose(@cancellation_request,contactCancellationRequest)
	end
	def destroy
		@cancellation_request = CancellationRequest.lumniStart(params,current_company, list: current_user.template('CancellationRequest','cancellation_requests',current_user))
		contactCancellationRequest = @cancellation_request.lumniSave(params,current_user, list: current_user.template('CancellationRequest','cancellation_requests',current_user))
		lumniClose(@cluster,contactCancellationRequest)
	end
end