class ResearchInputsController < ApplicationController
	def index
		@research_input = ResearchInput.lumniStart(params,current_company, list: current_user.template('ResearchInput','research_inputs',current_user)).limit(10)
		contactResearchInput = @research_input.lumniSave(params,current_user, list: current_user.template('ResearchInput','research_inputs',current_user))
		lumniClose(@research_input,contactResearchInput)
	end

	def new
		@research_input = ResearchInput.lumniStart(params,current_company, list: current_user.template('ResearchInput','research_inputs',current_user))
		contactResearchInput = @research_input.lumniSave(params,current_user, list: current_user.template('ResearchInput','research_inputs',current_user))
		lumniClose(@research_input,contactResearchInput)
	end

	def create
		@research_input = ResearchInput.lumniStart(params,current_company, list: current_user.template('ResearchInput','research_inputs',current_user))
		contactResearchInput = @research_input.lumniSave(params,current_user, list: current_user.template('ResearchInput','research_inputs',current_user))
		lumniClose(@research_input,contactResearchInput)
	end

	def edit
		@research_input = ResearchInput.lumniStart(params,current_company, list: current_user.template('ResearchInput','research_inputs',current_user))
		contactResearchInput = @research_input.lumniSave(params,current_user, list: current_user.template('ResearchInput','research_inputs',current_user))
		lumniClose(@research_input,contactResearchInput)
	end

	def update
		@research_input = ResearchInput.lumniStart(params,current_company, list: current_user.template('ResearchInput','research_inputs',current_user))
		contactResearchInput = @research_input.lumniSave(params,current_user, list: current_user.template('ResearchInput','research_inputs',current_user))
		lumniClose(@research_input,contactResearchInput)
	end
	def destroy
		@research_input = ResearchInput.lumniStart(params,current_company, list: current_user.template('ResearchInput','research_inputs',current_user))
		contactResearchInput = @research_input.lumniSave(params,current_user, list: current_user.template('ResearchInput','research_inputs',current_user))
		lumniClose(@cluster,contactResearchInput)
	end
end