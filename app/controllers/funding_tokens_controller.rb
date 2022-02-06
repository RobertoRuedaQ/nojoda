class FundingTokensController < ApplicationController
	def index
		@funding_token = FundingToken.lumniStart(params,current_company, list: current_user.template('FundingToken','funding_tokens',current_user))
		contactFundingToken = @funding_token.lumniSave(params,current_user, list: current_user.template('FundingToken','funding_tokens',current_user))
		lumniClose(@funding_token,contactFundingToken)
	end

	def new
		@funding_token = FundingToken.lumniStart(params,current_company, list: current_user.template('FundingToken','funding_tokens',current_user))
		contactFundingToken = @funding_token.lumniSave(params,current_user, list: current_user.template('FundingToken','funding_tokens',current_user))
		lumniClose(@funding_token,contactFundingToken)
	end

	def create
		@funding_token = FundingToken.lumniStart(params,current_company, list: current_user.template('FundingToken','funding_tokens',current_user))
		contactFundingToken = @funding_token.lumniSave(params,current_user, list: current_user.template('FundingToken','funding_tokens',current_user))
		lumniClose(@funding_token,contactFundingToken)
	end

	def edit
		@funding_token = FundingToken.lumniStart(params,current_company, list: current_user.template('FundingToken','funding_tokens',current_user))
		contactFundingToken = @funding_token.lumniSave(params,current_user, list: current_user.template('FundingToken','funding_tokens',current_user))
		lumniClose(@funding_token,contactFundingToken)
	end

	def update
		@funding_token = FundingToken.lumniStart(params,current_company, list: current_user.template('FundingToken','funding_tokens',current_user))
		contactFundingToken = @funding_token.lumniSave(params,current_user, list: current_user.template('FundingToken','funding_tokens',current_user))
		lumniClose(@funding_token,contactFundingToken)
	end
	def destroy
		@funding_token = FundingToken.lumniStart(params,current_company, list: current_user.template('FundingToken','funding_tokens',current_user))
		contactFundingToken = @funding_token.lumniSave(params,current_user, list: current_user.template('FundingToken','funding_tokens',current_user))
		lumniClose(@cluster,contactFundingToken)
	end

	def verify_token
		@funding_token = FundingToken.joins(:funding_opportunity).where(funding_opportunities: {id: params[:temp][:funding_opportunity_id]}).where(token: params[:funding_token][:token],token_status: "active").kept.first
		if !@funding_token.nil?
			@funding_token.user_id = params[:funding_token][:user_id]
			@funding_token.token_status = 'closed'
			if @funding_token.save
				@verified = true
			end
		end
	end
end