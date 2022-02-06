class FundingOpportunityInvitationsController < ApplicationController
	def index
		@funding_opportunity_invitation = FundingOpportunityInvitation.lumniStart(params,current_company, list: current_user.template('FundingOpportunityInvitation','funding_opportunity_invitations',current_user))
		contactFundingOpportunityInvitation = @funding_opportunity_invitation.lumniSave(params,current_user, list: current_user.template('FundingOpportunityInvitation','funding_opportunity_invitations',current_user))
		lumniClose(@funding_opportunity_invitation,contactFundingOpportunityInvitation)
	end

	def new
		@funding_opportunity_invitation = FundingOpportunityInvitation.lumniStart(params,current_company, list: current_user.template('FundingOpportunityInvitation','funding_opportunity_invitations',current_user))
		contactFundingOpportunityInvitation = @funding_opportunity_invitation.lumniSave(params,current_user, list: current_user.template('FundingOpportunityInvitation','funding_opportunity_invitations',current_user))
		lumniClose(@funding_opportunity_invitation,contactFundingOpportunityInvitation)
	end

	def create
		@funding_opportunity_invitation = FundingOpportunityInvitation.lumniStart(params,current_company, list: current_user.template('FundingOpportunityInvitation','funding_opportunity_invitations',current_user))
		contactFundingOpportunityInvitation = @funding_opportunity_invitation.lumniSave(params,current_user, list: current_user.template('FundingOpportunityInvitation','funding_opportunity_invitations',current_user))
		lumniClose(@funding_opportunity_invitation,contactFundingOpportunityInvitation)
	end

	def edit
		@funding_opportunity_invitation = FundingOpportunityInvitation.lumniStart(params,current_company, list: current_user.template('FundingOpportunityInvitation','funding_opportunity_invitations',current_user))
		contactFundingOpportunityInvitation = @funding_opportunity_invitation.lumniSave(params,current_user, list: current_user.template('FundingOpportunityInvitation','funding_opportunity_invitations',current_user))
		lumniClose(@funding_opportunity_invitation,contactFundingOpportunityInvitation)
	end

	def update
		@funding_opportunity_invitation = FundingOpportunityInvitation.lumniStart(params,current_company, list: current_user.template('FundingOpportunityInvitation','funding_opportunity_invitations',current_user))
		contactFundingOpportunityInvitation = @funding_opportunity_invitation.lumniSave(params,current_user, list: current_user.template('FundingOpportunityInvitation','funding_opportunity_invitations',current_user))
		lumniClose(@funding_opportunity_invitation,contactFundingOpportunityInvitation)
	end
	def destroy
		@funding_opportunity_invitation = FundingOpportunityInvitation.lumniStart(params,current_company, list: current_user.template('FundingOpportunityInvitation','funding_opportunity_invitations',current_user))
		contactFundingOpportunityInvitation = @funding_opportunity_invitation.lumniSave(params,current_user, list: current_user.template('FundingOpportunityInvitation','funding_opportunity_invitations',current_user))
		lumniClose(@cluster,contactFundingOpportunityInvitation)
	end
end