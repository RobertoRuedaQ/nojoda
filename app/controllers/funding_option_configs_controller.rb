class FundingOptionConfigsController < ApplicationController
	def index
		@funding_option_config = FundingOptionConfig.lumniStart(params,current_company, list: current_user.template('FundingOptionConfig','funding_option_configs',current_user))
		contactFundingOptionConfig = @funding_option_config.lumniSave(params,current_user, list: current_user.template('FundingOptionConfig','funding_option_configs',current_user))
		lumniClose(@funding_option_config,contactFundingOptionConfig)
	end

	def new
		@funding_option_config = FundingOptionConfig.lumniStart(params,current_company, list: current_user.template('FundingOptionConfig','funding_option_configs',current_user))
		contactFundingOptionConfig = @funding_option_config.lumniSave(params,current_user, list: current_user.template('FundingOptionConfig','funding_option_configs',current_user))
		lumniClose(@funding_option_config,contactFundingOptionConfig)
	end

	def create
		@funding_option_config = FundingOptionConfig.lumniStart(params,current_company, list: current_user.template('FundingOptionConfig','funding_option_configs',current_user))
		contactFundingOptionConfig = @funding_option_config.lumniSave(params,current_user, list: current_user.template('FundingOptionConfig','funding_option_configs',current_user))
		lumniClose(@funding_option_config,contactFundingOptionConfig)
	end

	def edit
		@funding_option_config = FundingOptionConfig.lumniStart(params,current_company, list: current_user.template('FundingOptionConfig','funding_option_configs',current_user))
		contactFundingOptionConfig = @funding_option_config.lumniSave(params,current_user, list: current_user.template('FundingOptionConfig','funding_option_configs',current_user))
		lumniClose(@funding_option_config,contactFundingOptionConfig)
	end

	def update
		@funding_option_config = FundingOptionConfig.lumniStart(params,current_company, list: current_user.template('FundingOptionConfig','funding_option_configs',current_user))
		contactFundingOptionConfig = @funding_option_config.lumniSave(params,current_user, list: current_user.template('FundingOptionConfig','funding_option_configs',current_user))
		lumniClose(@funding_option_config,contactFundingOptionConfig)
	end
	def destroy
		@funding_option_config = FundingOptionConfig.lumniStart(params,current_company, list: current_user.template('FundingOptionConfig','funding_option_configs',current_user))
		contactFundingOptionConfig = @funding_option_config.lumniSave(params,current_user, list: current_user.template('FundingOptionConfig','funding_option_configs',current_user))
		lumniClose(@cluster,contactFundingOptionConfig)
	end
end