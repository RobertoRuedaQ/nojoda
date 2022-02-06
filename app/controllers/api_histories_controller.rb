class ApiHistoriesController < ApplicationController
	def index
		@api_history = ApiHistory.select(:id, :url, :context, :status, :response_time, :user_id, :verb).lumniStart(params,current_company, list: current_user.template('ApiHistory','api_histories',current_user))
		contactApiHistory = @api_history.lumniSave(params,current_user, list: current_user.template('ApiHistory','api_histories',current_user))
		lumniClose(@api_history,contactApiHistory)
	end

	def new
		@api_history = ApiHistory.lumniStart(params,current_company, list: current_user.template('ApiHistory','api_histories',current_user))
		contactApiHistory = @api_history.lumniSave(params,current_user, list: current_user.template('ApiHistory','api_histories',current_user))
		lumniClose(@api_history,contactApiHistory)
	end

	def create
		@api_history = ApiHistory.lumniStart(params,current_company, list: current_user.template('ApiHistory','api_histories',current_user))
		contactApiHistory = @api_history.lumniSave(params,current_user, list: current_user.template('ApiHistory','api_histories',current_user))
		lumniClose(@api_history,contactApiHistory)
	end

	def edit
		@api_history = ApiHistory.lumniStart(params,current_company, list: current_user.template('ApiHistory','api_histories',current_user))
		contactApiHistory = @api_history.lumniSave(params,current_user, list: current_user.template('ApiHistory','api_histories',current_user))
		lumniClose(@api_history,contactApiHistory)
	end

	def update
		@api_history = ApiHistory.lumniStart(params,current_company, list: current_user.template('ApiHistory','api_histories',current_user))
		contactApiHistory = @api_history.lumniSave(params,current_user, list: current_user.template('ApiHistory','api_histories',current_user))
		lumniClose(@api_history,contactApiHistory)
	end
	def destroy
		@api_history = ApiHistory.lumniStart(params,current_company, list: current_user.template('ApiHistory','api_histories',current_user))
		contactApiHistory = @api_history.lumniSave(params,current_user, list: current_user.template('ApiHistory','api_histories',current_user))
		lumniClose(@cluster,contactApiHistory)
	end
end