class UserAggregationsController < ApplicationController
	def index
		@user_aggregation = UserAggregation.lumniStart(params,current_company, list: current_user.template('UserAggregation','user_aggregations',current_user))
		contactUserAggregation = @user_aggregation.lumniSave(params,current_user, list: current_user.template('UserAggregation','user_aggregations',current_user))
		lumniClose(@user_aggregation,contactUserAggregation)
	end

	def new
		@user_aggregation = UserAggregation.lumniStart(params,current_company, list: current_user.template('UserAggregation','user_aggregations',current_user))
		contactUserAggregation = @user_aggregation.lumniSave(params,current_user, list: current_user.template('UserAggregation','user_aggregations',current_user))
		lumniClose(@user_aggregation,contactUserAggregation)
	end

	def create
		@user_aggregation = UserAggregation.lumniStart(params,current_company, list: current_user.template('UserAggregation','user_aggregations',current_user))
		contactUserAggregation = @user_aggregation.lumniSave(params,current_user, list: current_user.template('UserAggregation','user_aggregations',current_user))
		lumniClose(@user_aggregation,contactUserAggregation)
	end

	def edit
		@user_aggregation = UserAggregation.lumniStart(params,current_company, list: current_user.template('UserAggregation','user_aggregations',current_user))
		contactUserAggregation = @user_aggregation.lumniSave(params,current_user, list: current_user.template('UserAggregation','user_aggregations',current_user))
		lumniClose(@user_aggregation,contactUserAggregation)
	end

	def update
		@user_aggregation = UserAggregation.lumniStart(params,current_company, list: current_user.template('UserAggregation','user_aggregations',current_user))
		contactUserAggregation = @user_aggregation.lumniSave(params,current_user, list: current_user.template('UserAggregation','user_aggregations',current_user))
		lumniClose(@user_aggregation,contactUserAggregation)
	end
	def destroy
		@user_aggregation = UserAggregation.lumniStart(params,current_company, list: current_user.template('UserAggregation','user_aggregations',current_user))
		contactUserAggregation = @user_aggregation.lumniSave(params,current_user, list: current_user.template('UserAggregation','user_aggregations',current_user))
		lumniClose(@cluster,contactUserAggregation)
	end
end