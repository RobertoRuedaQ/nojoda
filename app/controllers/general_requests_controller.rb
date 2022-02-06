class GeneralRequestsController < ApplicationController
	def index
		@general_request = GeneralRequest.lumniStart(params,current_company, list: current_user.template('GeneralRequest','general_requests',current_user))
		contactGeneralRequest = @general_request.lumniSave(params,current_user, list: current_user.template('GeneralRequest','general_requests',current_user))
		lumniClose(@general_request,contactGeneralRequest)
	end

	def new
		@general_request = GeneralRequest.lumniStart(params,current_company, list: current_user.template('GeneralRequest','general_requests',current_user))
		contactGeneralRequest = @general_request.lumniSave(params,current_user, list: current_user.template('GeneralRequest','general_requests',current_user))
		lumniClose(@general_request,contactGeneralRequest)
	end

	def create
		@general_request = GeneralRequest.lumniStart(params,current_company, list: current_user.template('GeneralRequest','general_requests',current_user))
		contactGeneralRequest = @general_request.lumniSave(params,current_user, list: current_user.template('GeneralRequest','general_requests',current_user))
		lumniClose(@general_request,contactGeneralRequest)
	end

	def edit
		@general_request = GeneralRequest.lumniStart(params,current_company, list: current_user.template('GeneralRequest','general_requests',current_user))
		contactGeneralRequest = @general_request.lumniSave(params,current_user, list: current_user.template('GeneralRequest','general_requests',current_user))
		lumniClose(@general_request,contactGeneralRequest)
	end

	def update
		@general_request = GeneralRequest.lumniStart(params,current_company, list: current_user.template('GeneralRequest','general_requests',current_user))
		contactGeneralRequest = @general_request.lumniSave(params,current_user, list: current_user.template('GeneralRequest','general_requests',current_user))
		lumniClose(@general_request,contactGeneralRequest)
	end
	def destroy
		@general_request = GeneralRequest.lumniStart(params,current_company, list: current_user.template('GeneralRequest','general_requests',current_user))
		contactGeneralRequest = @general_request.lumniSave(params,current_user, list: current_user.template('GeneralRequest','general_requests',current_user))
		lumniClose(@cluster,contactGeneralRequest)
	end
end