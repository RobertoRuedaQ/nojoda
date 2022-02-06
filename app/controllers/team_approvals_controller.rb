class TeamApprovalsController < ApplicationController
	def index
		@team_approval = TeamApproval.lumniStart(params,current_company)
		contactTeamApproval = @team_approval.lumniSave(params,current_user)
		lumniClose(@team_approval,contactTeamApproval)
	end

	def new
		@team_approval = TeamApproval.lumniStart(params,current_company)
		contactTeamApproval = @team_approval.lumniSave(params,current_user)
		lumniClose(@team_approval,contactTeamApproval)
	end

	def create
		@team_approval = TeamApproval.lumniStart(params,current_company)
		contactTeamApproval = @team_approval.lumniSave(params,current_user)
		lumniClose(@team_approval,contactTeamApproval)
	end

	def edit
		@team_approval = TeamApproval.lumniStart(params,current_company)
		contactTeamApproval = @team_approval.lumniSave(params,current_user)
		lumniClose(@team_approval,contactTeamApproval)
	end

	def update
		@team_approval = TeamApproval.lumniStart(params,current_company)
		contactTeamApproval = @team_approval.lumniSave(params,current_user)
		lumniClose(@team_approval,contactTeamApproval)
	end
	def destroy
		@team_approval = TeamApproval.lumniStart(params,current_company)
		contactTeamApproval = @team_approval.lumniSave(params,current_user)
		lumniClose(@cluster,contactTeamApproval)
	end
end