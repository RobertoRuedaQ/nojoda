class ResearchFiltersController < ApplicationController
	def index
		@research_filter = ResearchFilter.lumniStart(params,current_company, list: current_user.template('ResearchFilter','research_filters',current_user))
		contactResearchFilter = @research_filter.lumniSave(params,current_user, list: current_user.template('ResearchFilter','research_filters',current_user))
		lumniClose(@research_filter,contactResearchFilter)
	end

	def new
		@research_filter = ResearchFilter.lumniStart(params,current_company, list: current_user.template('ResearchFilter','research_filters',current_user))
		contactResearchFilter = @research_filter.lumniSave(params,current_user, list: current_user.template('ResearchFilter','research_filters',current_user))
		lumniClose(@research_filter,contactResearchFilter)
	end

	def create
		@research_filter = ResearchFilter.lumniStart(params,current_company, list: current_user.template('ResearchFilter','research_filters',current_user))
		contactResearchFilter = @research_filter.lumniSave(params,current_user, list: current_user.template('ResearchFilter','research_filters',current_user))
		lumniClose(@research_filter,contactResearchFilter)
	end

	def edit
		@research_filter = ResearchFilter.lumniStart(params,current_company, list: current_user.template('ResearchFilter','research_filters',current_user))
		contactResearchFilter = @research_filter.lumniSave(params,current_user, list: current_user.template('ResearchFilter','research_filters',current_user))
		lumniClose(@research_filter,contactResearchFilter)
	end

	def update
		@research_filter = ResearchFilter.lumniStart(params,current_company, list: current_user.template('ResearchFilter','research_filters',current_user))
		contactResearchFilter = @research_filter.lumniSave(params,current_user, list: current_user.template('ResearchFilter','research_filters',current_user))
		lumniClose(@research_filter,contactResearchFilter)
	end
	def destroy
		@research_filter = ResearchFilter.lumniStart(params,current_company, list: current_user.template('ResearchFilter','research_filters',current_user))
		contactResearchFilter = @research_filter.lumniSave(params,current_user, list: current_user.template('ResearchFilter','research_filters',current_user))
		lumniClose(@cluster,contactResearchFilter)
	end
end