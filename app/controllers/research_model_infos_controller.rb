class ResearchModelInfosController < ApplicationController
	def index
		@research_model_info = ResearchModelInfo.lumniStart(params,current_company, list: current_user.template('ResearchModelInfo','research_model_infos',current_user)).limit(10)
		contactResearchModelInfo = @research_model_info.lumniSave(params,current_user, list: current_user.template('ResearchModelInfo','research_model_infos',current_user))
		lumniClose(@research_model_info,contactResearchModelInfo)
	end

	def new
		@research_model_info = ResearchModelInfo.lumniStart(params,current_company, list: current_user.template('ResearchModelInfo','research_model_infos',current_user))
		contactResearchModelInfo = @research_model_info.lumniSave(params,current_user, list: current_user.template('ResearchModelInfo','research_model_infos',current_user))
		lumniClose(@research_model_info,contactResearchModelInfo)
	end

	def create
		@research_model_info = ResearchModelInfo.lumniStart(params,current_company, list: current_user.template('ResearchModelInfo','research_model_infos',current_user))
		contactResearchModelInfo = @research_model_info.lumniSave(params,current_user, list: current_user.template('ResearchModelInfo','research_model_infos',current_user))
		lumniClose(@research_model_info,contactResearchModelInfo)
	end

	def edit
		@research_model_info = ResearchModelInfo.lumniStart(params,current_company, list: current_user.template('ResearchModelInfo','research_model_infos',current_user))
		contactResearchModelInfo = @research_model_info.lumniSave(params,current_user, list: current_user.template('ResearchModelInfo','research_model_infos',current_user))
		lumniClose(@research_model_info,contactResearchModelInfo)
	end

	def update
		@research_model_info = ResearchModelInfo.lumniStart(params,current_company, list: current_user.template('ResearchModelInfo','research_model_infos',current_user))
		contactResearchModelInfo = @research_model_info.lumniSave(params,current_user, list: current_user.template('ResearchModelInfo','research_model_infos',current_user))
		lumniClose(@research_model_info,contactResearchModelInfo)
	end
	def destroy
		@research_model_info = ResearchModelInfo.lumniStart(params,current_company, list: current_user.template('ResearchModelInfo','research_model_infos',current_user))
		contactResearchModelInfo = @research_model_info.lumniSave(params,current_user, list: current_user.template('ResearchModelInfo','research_model_infos',current_user))
		lumniClose(@cluster,contactResearchModelInfo)
	end
end