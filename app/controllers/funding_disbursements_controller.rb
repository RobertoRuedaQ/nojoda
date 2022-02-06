class FundingDisbursementsController < ApplicationController
	def index
		@funding_disbursement = FundingDisbursement.lumniStart(params,current_company, list: current_user.template('FundingDisbursement','funding_disbursements',current_user))
		contactFundingDisbursement = @funding_disbursement.lumniSave(params,current_user, list: current_user.template('FundingDisbursement','funding_disbursements',current_user))
		lumniClose(@funding_disbursement,contactFundingDisbursement)
	end

	def new
		@funding_disbursement = FundingDisbursement.lumniStart(params,current_company, list: current_user.template('FundingDisbursement','funding_disbursements',current_user))
		contactFundingDisbursement = @funding_disbursement.lumniSave(params,current_user, list: current_user.template('FundingDisbursement','funding_disbursements',current_user))
		lumniClose(@funding_disbursement,contactFundingDisbursement)
	end

	def create
		@funding_disbursement = FundingDisbursement.lumniStart(params,current_company, list: current_user.template('FundingDisbursement','funding_disbursements',current_user))
		contactFundingDisbursement = @funding_disbursement.lumniSave(params,current_user, list: current_user.template('FundingDisbursement','funding_disbursements',current_user))
		lumniClose(@funding_disbursement,contactFundingDisbursement)
	end

	def edit
		@funding_disbursement = FundingDisbursement.lumniStart(params,current_company, list: current_user.template('FundingDisbursement','funding_disbursements',current_user))
		contactFundingDisbursement = @funding_disbursement.lumniSave(params,current_user, list: current_user.template('FundingDisbursement','funding_disbursements',current_user))
		lumniClose(@funding_disbursement,contactFundingDisbursement)
	end

	def update
		@funding_disbursement = FundingDisbursement.lumniStart(params,current_company, list: current_user.template('FundingDisbursement','funding_disbursements',current_user))
		contactFundingDisbursement = @funding_disbursement.lumniSave(params,current_user, list: current_user.template('FundingDisbursement','funding_disbursements',current_user))
		lumniClose(@funding_disbursement,contactFundingDisbursement)
	end
	def destroy
		@funding_disbursement = FundingDisbursement.lumniStart(params,current_company, list: current_user.template('FundingDisbursement','funding_disbursements',current_user))
		contactFundingDisbursement = @funding_disbursement.lumniSave(params,current_user, list: current_user.template('FundingDisbursement','funding_disbursements',current_user))
		lumniClose(@cluster,contactFundingDisbursement)
	end
end