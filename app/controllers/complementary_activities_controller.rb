class ComplementaryActivitiesController < ApplicationController
	def index
		@complementary_activity = ComplementaryActivity.lumniStart(params,current_company, list: current_user.template('ComplementaryActivity','complementary_activities',current_user))
		contactComplementaryActivity = @complementary_activity.lumniSave(params,current_user, list: current_user.template('ComplementaryActivity','complementary_activities',current_user))
		lumniClose(@complementary_activity,contactComplementaryActivity)
	end

	def new
		@complementary_activity = ComplementaryActivity.lumniStart(params,current_company, list: current_user.template('ComplementaryActivity','complementary_activities',current_user))
		contactComplementaryActivity = @complementary_activity.lumniSave(params,current_user, list: current_user.template('ComplementaryActivity','complementary_activities',current_user))
		lumniClose(@complementary_activity,contactComplementaryActivity)
	end

	def create
		@complementary_activity = ComplementaryActivity.lumniStart(params,current_company, list: current_user.template('ComplementaryActivity','complementary_activities',current_user))
		contactComplementaryActivity = @complementary_activity.lumniSave(params,current_user, list: current_user.template('ComplementaryActivity','complementary_activities',current_user))
		lumniClose(@complementary_activity,contactComplementaryActivity)
	end

	def edit
		@complementary_activity = ComplementaryActivity.lumniStart(params,current_company, list: current_user.template('ComplementaryActivity','complementary_activities',current_user))
		contactComplementaryActivity = @complementary_activity.lumniSave(params,current_user, list: current_user.template('ComplementaryActivity','complementary_activities',current_user))
		lumniClose(@complementary_activity,contactComplementaryActivity)
	end

	def update
		@complementary_activity = ComplementaryActivity.lumniStart(params,current_company, list: current_user.template('ComplementaryActivity','complementary_activities',current_user))
		contactComplementaryActivity = @complementary_activity.lumniSave(params,current_user, list: current_user.template('ComplementaryActivity','complementary_activities',current_user))
		lumniClose(@complementary_activity,contactComplementaryActivity)
	end
	def destroy
		@complementary_activity = ComplementaryActivity.lumniStart(params,current_company, list: current_user.template('ComplementaryActivity','complementary_activities',current_user))
		contactComplementaryActivity = @complementary_activity.lumniSave(params,current_user, list: current_user.template('ComplementaryActivity','complementary_activities',current_user))
		lumniClose(@cluster,contactComplementaryActivity)
	end
end