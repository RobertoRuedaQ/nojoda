class FundingOptionDisbursementsController < ApplicationController
	def index
		@funding_option_disbursement = FundingOptionDisbursement.lumniStart(params,current_company, list: current_user.template('FundingOptionDisbursement','funding_option_disbursements',current_user))
		contactFundingOptionDisbursement = @funding_option_disbursement.lumniSave(params,current_user, list: current_user.template('FundingOptionDisbursement','funding_option_disbursements',current_user))
		lumniClose(@funding_option_disbursement,contactFundingOptionDisbursement)
	end

	def new
		@funding_option_disbursement = FundingOptionDisbursement.lumniStart(params,current_company, list: current_user.template('FundingOptionDisbursement','funding_option_disbursements',current_user))
		contactFundingOptionDisbursement = @funding_option_disbursement.lumniSave(params,current_user, list: current_user.template('FundingOptionDisbursement','funding_option_disbursements',current_user))
		lumniClose(@funding_option_disbursement,contactFundingOptionDisbursement)
	end

	def create
		@funding_option_disbursement = FundingOptionDisbursement.lumniStart(params,current_company, list: current_user.template('FundingOptionDisbursement','funding_option_disbursements',current_user))
		contactFundingOptionDisbursement = @funding_option_disbursement.lumniSave(params,current_user, list: current_user.template('FundingOptionDisbursement','funding_option_disbursements',current_user))
		lumniClose(@funding_option_disbursement,contactFundingOptionDisbursement)
	end

	def edit
		@funding_option_disbursement = FundingOptionDisbursement.lumniStart(params,current_company, list: current_user.template('FundingOptionDisbursement','funding_option_disbursements',current_user))
		contactFundingOptionDisbursement = @funding_option_disbursement.lumniSave(params,current_user, list: current_user.template('FundingOptionDisbursement','funding_option_disbursements',current_user))
		lumniClose(@funding_option_disbursement,contactFundingOptionDisbursement)
	end

	def update
		@funding_option_disbursement = FundingOptionDisbursement.lumniStart(params,current_company, list: current_user.template('FundingOptionDisbursement','funding_option_disbursements',current_user))
		contactFundingOptionDisbursement = @funding_option_disbursement.lumniSave(params,current_user, list: current_user.template('FundingOptionDisbursement','funding_option_disbursements',current_user))
		lumniClose(@funding_option_disbursement,contactFundingOptionDisbursement)
	end
	def destroy
		@funding_option_disbursement = FundingOptionDisbursement.lumniStart(params,current_company, list: current_user.template('FundingOptionDisbursement','funding_option_disbursements',current_user))
		contactFundingOptionDisbursement = @funding_option_disbursement.lumniSave(params,current_user, list: current_user.template('FundingOptionDisbursement','funding_option_disbursements',current_user))
		lumniClose(@cluster,contactFundingOptionDisbursement)
	end
end