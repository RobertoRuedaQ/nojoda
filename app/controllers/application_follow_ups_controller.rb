class ApplicationFollowUpsController < ApplicationController
	def index
		@application_follow_up = ApplicationFollowUp.lumniStart(params,current_company, list: current_user.template('ApplicationFollowUp','application_follow_ups',current_user))
		applicationFollowUp = @application_follow_up.lumniSave(params,current_user, list: current_user.template('ApplicationFollowUp','application_follow_ups',current_user))
		lumniClose(@application_follow_up,applicationFollowUp)
	end

	def new
		@application_follow_up = ApplicationFollowUp.lumniStart(params,current_company, list: current_user.template('ApplicationFollowUp','application_follow_ups',current_user))
		applicationFollowUp = @application_follow_up.lumniSave(params,current_user, list: current_user.template('ApplicationFollowUp','application_follow_ups',current_user))
		lumniClose(@application_follow_up,applicationFollowUp)
	end

	def create
		@application_follow_up = ApplicationFollowUp.lumniStart(params,current_company, list: current_user.template('ApplicationFollowUp','application_follow_ups',current_user))
		applicationFollowUp = @application_follow_up.lumniSave(params,current_user, list: current_user.template('ApplicationFollowUp','application_follow_ups',current_user))
		lumniClose(@application_follow_up,applicationFollowUp)
	end

	def edit
		@application_follow_up = ApplicationFollowUp.lumniStart(params,current_company, list: current_user.template('ApplicationFollowUp','application_follow_ups',current_user))
		applicationFollowUp = @application_follow_up.lumniSave(params,current_user, list: current_user.template('ApplicationFollowUp','application_follow_ups',current_user))
		lumniClose(@application_follow_up,applicationFollowUp)
	end

	def update
		@application_follow_up = ApplicationFollowUp.lumniStart(params,current_company, list: current_user.template('ApplicationFollowUp','application_follow_ups',current_user))
		applicationFollowUp = @application_follow_up.lumniSave(params,current_user, list: current_user.template('ApplicationFollowUp','application_follow_ups',current_user))
		lumniClose(@application_follow_up,applicationFollowUp)
	end
	def destroy
		@application_follow_up = ApplicationFollowUp.lumniStart(params,current_company, list: current_user.template('ApplicationFollowUp','application_follow_ups',current_user))
		applicationFollowUp = @application_follow_up.lumniSave(params,current_user, list: current_user.template('ApplicationFollowUp','application_follow_ups',current_user))
		lumniClose(@cluster,applicationFollowUp)
	end
end