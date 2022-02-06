class ResearchVariablesController < ApplicationController
	def index
		@research_variable = ResearchVariable.lumniStart(params,current_company, list: current_user.template('ResearchVariable','research_variables',current_user))
		contactResearchVariable = @research_variable.lumniSave(params,current_user, list: current_user.template('ResearchVariable','research_variables',current_user))
		lumniClose(@research_variable,contactResearchVariable)
	end

	def new
		@research_variable = ResearchVariable.lumniStart(params,current_company, list: current_user.template('ResearchVariable','research_variables',current_user))
		contactResearchVariable = @research_variable.lumniSave(params,current_user, list: current_user.template('ResearchVariable','research_variables',current_user))
		lumniClose(@research_variable,contactResearchVariable)
	end

	def create
		@research_variable = ResearchVariable.lumniStart(params,current_company, list: current_user.template('ResearchVariable','research_variables',current_user))
		contactResearchVariable = @research_variable.lumniSave(params,current_user, list: current_user.template('ResearchVariable','research_variables',current_user))
		lumniClose(@research_variable,contactResearchVariable)
	end

	def edit
		@research_variable = ResearchVariable.lumniStart(params,current_company, list: current_user.template('ResearchVariable','research_variables',current_user))
		contactResearchVariable = @research_variable.lumniSave(params,current_user, list: current_user.template('ResearchVariable','research_variables',current_user))
		lumniClose(@research_variable,contactResearchVariable)
	end

	def update
		@research_variable = ResearchVariable.lumniStart(params,current_company, list: current_user.template('ResearchVariable','research_variables',current_user))
		contactResearchVariable = @research_variable.lumniSave(params,current_user, list: current_user.template('ResearchVariable','research_variables',current_user))
		lumniClose(@research_variable,contactResearchVariable)
	end
	def destroy
		@research_variable = ResearchVariable.lumniStart(params,current_company, list: current_user.template('ResearchVariable','research_variables',current_user))
		contactResearchVariable = @research_variable.lumniSave(params,current_user, list: current_user.template('ResearchVariable','research_variables',current_user))
		lumniClose(@cluster,contactResearchVariable)
	end
end