class FundingOptionStatusesController < ApplicationController
	def index
		@funding_option_status = FundingOptionStatus.lumniStart(params,current_company, list: current_user.template('FundingOptionStatus','funding_option_statuses',current_user))
		contactFundingOptionStatus = @funding_option_status.lumniSave(params,current_user, list: current_user.template('FundingOptionStatus','funding_option_statuses',current_user))
		lumniClose(@funding_option_status,contactFundingOptionStatus)
	end

	def new
		@funding_option_status = FundingOptionStatus.lumniStart(params,current_company, list: current_user.template('FundingOptionStatus','funding_option_statuses',current_user))
		contactFundingOptionStatus = @funding_option_status.lumniSave(params,current_user, list: current_user.template('FundingOptionStatus','funding_option_statuses',current_user))
		lumniClose(@funding_option_status,contactFundingOptionStatus)
	end

	def create
		@funding_option_status = FundingOptionStatus.lumniStart(params,current_company, list: current_user.template('FundingOptionStatus','funding_option_statuses',current_user))
		contactFundingOptionStatus = @funding_option_status.lumniSave(params,current_user, list: current_user.template('FundingOptionStatus','funding_option_statuses',current_user))
		lumniClose(@funding_option_status,contactFundingOptionStatus)
	end

	def edit
		@funding_option_status = FundingOptionStatus.lumniStart(params,current_company, list: current_user.template('FundingOptionStatus','funding_option_statuses',current_user))
		contactFundingOptionStatus = @funding_option_status.lumniSave(params,current_user, list: current_user.template('FundingOptionStatus','funding_option_statuses',current_user))
		lumniClose(@funding_option_status,contactFundingOptionStatus)
	end

	def update
		@funding_option_status = FundingOptionStatus.lumniStart(params,current_company, list: current_user.template('FundingOptionStatus','funding_option_statuses',current_user))
		contactFundingOptionStatus = @funding_option_status.lumniSave(params,current_user, list: current_user.template('FundingOptionStatus','funding_option_statuses',current_user))
		lumniClose(@funding_option_status,contactFundingOptionStatus)
	end
	def destroy
		@funding_option_status = FundingOptionStatus.lumniStart(params,current_company, list: current_user.template('FundingOptionStatus','funding_option_statuses',current_user))
		contactFundingOptionStatus = @funding_option_status.lumniSave(params,current_user, list: current_user.template('FundingOptionStatus','funding_option_statuses',current_user))
		lumniClose(@cluster,contactFundingOptionStatus)
	end
end