class TeamProfileTemplatesController < ApplicationController
	def index
		@team_profile_template = TeamProfileTemplate.lumniStart(params,current_company)
		contactTeamProfileTemplate = @team_profile_template.lumniSave(params,current_user)
		lumniClose(@team_profile_template,contactTeamProfileTemplate)
	end

	def new
		@team_profile_template = TeamProfileTemplate.lumniStart(params,current_company)
		contactTeamProfileTemplate = @team_profile_template.lumniSave(params,current_user)
		lumniClose(@team_profile_template,contactTeamProfileTemplate)
	end

	def create
		@team_profile_template = TeamProfileTemplate.lumniStart(params,current_company)
		contactTeamProfileTemplate = @team_profile_template.lumniSave(params,current_user)
		lumniClose(@team_profile_template,contactTeamProfileTemplate)
	end

	def edit
		@team_profile_template = TeamProfileTemplate.lumniStart(params,current_company)
		contactTeamProfileTemplate = @team_profile_template.lumniSave(params,current_user)
		lumniClose(@team_profile_template,contactTeamProfileTemplate)
	end

	def update
		@team_profile_template = TeamProfileTemplate.lumniStart(params,current_company)
		contactTeamProfileTemplate = @team_profile_template.lumniSave(params,current_user)
		lumniClose(@team_profile_template,contactTeamProfileTemplate)
	end
	def destroy
		@team_profile_template = TeamProfileTemplate.lumniStart(params,current_company)
		contactTeamProfileTemplate = @team_profile_template.lumniSave(params,current_user)
		lumniClose(@cluster,contactTeamProfileTemplate)
	end
end