class FundingNeedsController < ApplicationController
	def index
		@funding_need = FundingNeed.lumniStart(params,current_company, list: current_user.template('FundingNeed','funding_needs',current_user))
		contactFundingNeed = @funding_need.lumniSave(params,current_user, list: current_user.template('FundingNeed','funding_needs',current_user))
		lumniClose(@funding_need,contactFundingNeed)
	end

	def new
		@funding_need = FundingNeed.lumniStart(params,current_company, list: current_user.template('FundingNeed','funding_needs',current_user))
		contactFundingNeed = @funding_need.lumniSave(params,current_user, list: current_user.template('FundingNeed','funding_needs',current_user))
		lumniClose(@funding_need,contactFundingNeed)
	end

	def create
		@funding_need = FundingNeed.lumniStart(params,current_company, list: current_user.template('FundingNeed','funding_needs',current_user))
		contactFundingNeed = @funding_need.lumniSave(params,current_user, list: current_user.template('FundingNeed','funding_needs',current_user))
		lumniClose(@funding_need,contactFundingNeed)
	end

	def edit
		@funding_need = FundingNeed.lumniStart(params,current_company, list: current_user.template('FundingNeed','funding_needs',current_user))
		contactFundingNeed = @funding_need.lumniSave(params,current_user, list: current_user.template('FundingNeed','funding_needs',current_user))
		lumniClose(@funding_need,contactFundingNeed)
	end

	def update
		@funding_need = FundingNeed.lumniStart(params,current_company, list: current_user.template('FundingNeed','funding_needs',current_user))
		contactFundingNeed = @funding_need.lumniSave(params,current_user, list: current_user.template('FundingNeed','funding_needs',current_user))
		lumniClose(@funding_need,contactFundingNeed)
	end
	def destroy
		@funding_need = FundingNeed.lumniStart(params,current_company, list: current_user.template('FundingNeed','funding_needs',current_user))
		contactFundingNeed = @funding_need.lumniSave(params,current_user, list: current_user.template('FundingNeed','funding_needs',current_user))
		lumniClose(@cluster,contactFundingNeed)
	end
end