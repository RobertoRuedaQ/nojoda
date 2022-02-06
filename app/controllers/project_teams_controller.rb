class ProjectTeamsController < ApplicationController
	def index
		@project_team = ProjectTeam.lumniStart(params,current_company)
		projectTeam = @project_team.lumniSave(params,current_user)
		lumniClose(@project_team,projectTeam)
	end

	def new
		@project_team = ProjectTeam.lumniStart(params,current_company)
		projectTeam = @project_team.lumniSave(params,current_user)
		lumniClose(@project_team,projectTeam)
	end

	def create
		@project_team = ProjectTeam.lumniStart(params,current_company)
		projectTeam = @project_team.lumniSave(params,current_user)
		lumniClose(@project_team,projectTeam)
	end

	def edit
		@project_team = ProjectTeam.lumniStart(params,current_company)
		projectTeam = @project_team.lumniSave(params,current_user)
		lumniClose(@project_team,projectTeam)
	end

	def update
		@project_team = ProjectTeam.lumniStart(params,current_company)
		projectTeam = @project_team.lumniSave(params,current_user)
		lumniClose(@project_team,projectTeam)
	end
	def destroy
		@project_team = ProjectTeam.lumniStart(params,current_company)
		projectTeam = @project_team.lumniSave(params,current_user)
		lumniClose(@project_team,projectTeam)
		@result =projectTeam
	end

	def new_team_member
		@project = Project.cached_find(params[:id])
	end

	def update_teams
		@project = Project.cached_find(params[:id])
		currentTeam = @project.project_team.map{|t| t.user_id}
		selected = params[:team].map{|t| (t.is_a? String) ? t.to_i : nil}.compact
		members_to_drop = ProjectTeam.where(user_id: (currentTeam - selected),project_id: @project.id)
		members_to_add = selected - currentTeam

		if members_to_drop.length > 0

			ProjectTeam.destroy(members_to_drop.ids)
		end
		if members_to_add.length > 0
			ProjectTeam.create(members_to_add.map{|m| {user_id: m, project_id: @project.id}})
		end

	end
end
