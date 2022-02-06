class FundingOpportunityTeamsController < ApplicationController
	def index
		@funding_opportunity_team = FundingOpportunityTeam.lumniStart(params,current_company, list: current_user.template('FundingOpportunityTeam','funding_opportunity_teams',current_user))
		contactFundingOpportunityTeam = @funding_opportunity_team.lumniSave(params,current_user, list: current_user.template('FundingOpportunityTeam','funding_opportunity_teams',current_user))
		lumniClose(@funding_opportunity_team,contactFundingOpportunityTeam)
	end

	def new
		@funding_opportunity_team = FundingOpportunityTeam.lumniStart(params,current_company, list: current_user.template('FundingOpportunityTeam','funding_opportunity_teams',current_user))
		contactFundingOpportunityTeam = @funding_opportunity_team.lumniSave(params,current_user, list: current_user.template('FundingOpportunityTeam','funding_opportunity_teams',current_user))
		lumniClose(@funding_opportunity_team,contactFundingOpportunityTeam)
	end

	def create
		@funding_opportunity_team = FundingOpportunityTeam.lumniStart(params,current_company, list: current_user.template('FundingOpportunityTeam','funding_opportunity_teams',current_user))
		contactFundingOpportunityTeam = @funding_opportunity_team.lumniSave(params,current_user, list: current_user.template('FundingOpportunityTeam','funding_opportunity_teams',current_user))
		lumniClose(@funding_opportunity_team,contactFundingOpportunityTeam)
	end

	def edit
		@funding_opportunity_team = FundingOpportunityTeam.lumniStart(params,current_company, list: current_user.template('FundingOpportunityTeam','funding_opportunity_teams',current_user))
		contactFundingOpportunityTeam = @funding_opportunity_team.lumniSave(params,current_user, list: current_user.template('FundingOpportunityTeam','funding_opportunity_teams',current_user))
		lumniClose(@funding_opportunity_team,contactFundingOpportunityTeam)
	end

	def update
		@funding_opportunity_team = FundingOpportunityTeam.lumniStart(params,current_company, list: current_user.template('FundingOpportunityTeam','funding_opportunity_teams',current_user))
		contactFundingOpportunityTeam = @funding_opportunity_team.lumniSave(params,current_user, list: current_user.template('FundingOpportunityTeam','funding_opportunity_teams',current_user))
		lumniClose(@funding_opportunity_team,contactFundingOpportunityTeam)
	end
	def destroy
		@funding_opportunity_team = FundingOpportunityTeam.lumniStart(params,current_company, list: current_user.template('FundingOpportunityTeam','funding_opportunity_teams',current_user))
		contactFundingOpportunityTeam = @funding_opportunity_team.lumniSave(params,current_user, list: current_user.template('FundingOpportunityTeam','funding_opportunity_teams',current_user))
		lumniClose(@cluster,contactFundingOpportunityTeam)
	end

	def create_supervisor
		params[:member].each do |member|
			@funding_opportunity_team = FundingOpportunityTeam.create({funding_opportunity_id: params[:teams],user_id: member})
		end

	end

	def destroy_supervisor
		params[:member].each do |member|
			@funding_opportunity_team = FundingOpportunityTeam.where(funding_opportunity_id: params[:teams],user_id: member).cached_destroy_all
		end
	end

end