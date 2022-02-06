class TeamSupervisorsController < ApplicationController
	def index
		@team_supervisor = TeamSupervisor.lumniStart(params,current_company, list: current_user.template('TeamSupervisor','team_supervisors',current_user,current_company: current_company))
		contact_team_supervisor = @team_supervisor.lumniSave(params,current_user, list: current_user.template('TeamSupervisor','team_supervisors',current_user,current_company: current_company))
		lumniClose(@team_supervisor,contact_team_supervisor)
	end

	def new
		@team_supervisor = TeamSupervisor.lumniStart(params,current_company, list: current_user.template('TeamSupervisor','team_supervisors',current_user,current_company: current_company))
		contact_team_supervisor = @team_supervisor.lumniSave(params,current_user, list: current_user.template('TeamSupervisor','team_supervisors',current_user,current_company: current_company))
		lumniClose(@team_supervisor,contact_team_supervisor)
	end

	def create
		@team_supervisor = TeamSupervisor.create(team_supervisor_params)
		student_id =  params[:teamsupervisor][:team_member_id]

		if @team_supervisor
			flash[:success] = I18n.t('team_supervisor.flash.create.success')
		else
			flash[:danger] = I18n.t('team_supervisor.flash.create.danger')
		end

		redirect_to support_team_student_path(student_id)
	end

	def edit
		@team_supervisor = TeamSupervisor.lumniStart(params,current_company, list: current_user.template('TeamSupervisor','team_supervisors',current_user,current_company: current_company))
		contact_team_supervisor = @team_supervisor.lumniSave(params,current_user, list: current_user.template('TeamSupervisor','team_supervisors',current_user,current_company: current_company))
		lumniClose(@team_supervisor,contact_team_supervisor)
	end

	def update
		@team_supervisor = TeamSupervisor.lumniStart(params,current_company, list: current_user.template('TeamSupervisor','team_supervisors',current_user,current_company: current_company))
		contact_team_supervisor = @team_supervisor.lumniSave(params,current_user, list: current_user.template('TeamSupervisor','team_supervisors',current_user,current_company: current_company))
		lumniClose(@team_supervisor,contact_team_supervisor)
	end

	def destroy
		team_supervisor = TeamSupervisor.find_by(id: params[:id])
		student_id = params[:student_id]

		if team_supervisor
			if team_supervisor.destroy
				flash[:success] = I18n.t('team_supervisor.flash.remove.success')
			else
				flash[:danger] = I18n.t('team_supervisor.flash.remove.danger')
			end
		else
			flash[:danger] = I18n.t('team_supervisor.flash.not_found')
		end

		redirect_to support_team_student_path(student_id)
	end

	def create_supervisor
		params[:member].each do |member|
			@team_supervisor = TeamSupervisor.create({supervisor_id: params[:teams],team_member_id: member})
		end

	end

	def destroy_supervisor
		params[:member].each do |member|
			@team_supervisor = TeamSupervisor.where(supervisor_id: params[:teams],team_member_id: member).cached_destroy_all
		end
	end

	private

	def team_supervisor_params
		params.require(:teamsupervisor).permit(:support_role_id, :team_member_id, :supervisor_id)
	end


end
