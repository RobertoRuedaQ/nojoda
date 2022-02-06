class ResearchProcessesController < ApplicationController
	def index
		@research_process = ResearchProcess.lumniStart(params,current_company, list: current_user.template('ResearchProcess','research_processes',current_user)).limit(10)
		contactResearchProcess = @research_process.lumniSave(params,current_user, list: current_user.template('ResearchProcess','research_processes',current_user))
		lumniClose(@research_process,contactResearchProcess)
	end

	def new
		@research_process = ResearchProcess.lumniStart(params,current_company, list: current_user.template('ResearchProcess','research_processes',current_user))
		contactResearchProcess = @research_process.lumniSave(params,current_user, list: current_user.template('ResearchProcess','research_processes',current_user))
		lumniClose(@research_process,contactResearchProcess)
	end

	def create
		@research_process = ResearchProcess.lumniStart(params,current_company, list: current_user.template('ResearchProcess','research_processes',current_user))
		contactResearchProcess = @research_process.lumniSave(params,current_user, list: current_user.template('ResearchProcess','research_processes',current_user))
		lumniClose(@research_process,contactResearchProcess)
	end

	def edit
		@research_process = ResearchProcess.lumniStart(params,current_company, list: current_user.template('ResearchProcess','research_processes',current_user))
		contactResearchProcess = @research_process.lumniSave(params,current_user, list: current_user.template('ResearchProcess','research_processes',current_user))
		lumniClose(@research_process,contactResearchProcess)
	end

	def update
		@research_process = ResearchProcess.lumniStart(params,current_company, list: current_user.template('ResearchProcess','research_processes',current_user))
		contactResearchProcess = @research_process.lumniSave(params,current_user, list: current_user.template('ResearchProcess','research_processes',current_user))
		lumniClose(@research_process,contactResearchProcess)
	end
	def destroy
		@research_process = ResearchProcess.lumniStart(params,current_company, list: current_user.template('ResearchProcess','research_processes',current_user))
		contactResearchProcess = @research_process.lumniSave(params,current_user, list: current_user.template('ResearchProcess','research_processes',current_user))
		lumniClose(@cluster,contactResearchProcess)
	end
end