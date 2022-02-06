class CustomDisbursementsController < ApplicationController
	def index
		@custom_disbursement = CustomDisbursement.lumniStart(params,current_company, list: current_user.template('CustomDisbursement','custom_disbursements',current_user))
		contactCustomDisbursement = @custom_disbursement.lumniSave(params,current_user, list: current_user.template('CustomDisbursement','custom_disbursements',current_user))
		lumniClose(@custom_disbursement,contactCustomDisbursement)
	end

	def new
		@custom_disbursement = CustomDisbursement.lumniStart(params,current_company, list: current_user.template('CustomDisbursement','custom_disbursements',current_user))
		contactCustomDisbursement = @custom_disbursement.lumniSave(params,current_user, list: current_user.template('CustomDisbursement','custom_disbursements',current_user))
		lumniClose(@custom_disbursement,contactCustomDisbursement)
	end

	def create
		@custom_disbursement = CustomDisbursement.lumniStart(params,current_company, list: current_user.template('CustomDisbursement','custom_disbursements',current_user))
		contactCustomDisbursement = @custom_disbursement.lumniSave(params,current_user, list: current_user.template('CustomDisbursement','custom_disbursements',current_user))
		lumniClose(@custom_disbursement,contactCustomDisbursement)
	end

	def edit
		@custom_disbursement = CustomDisbursement.lumniStart(params,current_company, list: current_user.template('CustomDisbursement','custom_disbursements',current_user))
		contactCustomDisbursement = @custom_disbursement.lumniSave(params,current_user, list: current_user.template('CustomDisbursement','custom_disbursements',current_user))
		lumniClose(@custom_disbursement,contactCustomDisbursement)
	end

	def update
		@custom_disbursement = CustomDisbursement.lumniStart(params,current_company, list: current_user.template('CustomDisbursement','custom_disbursements',current_user))
		contactCustomDisbursement = @custom_disbursement.lumniSave(params,current_user, list: current_user.template('CustomDisbursement','custom_disbursements',current_user))
		lumniClose(@custom_disbursement,contactCustomDisbursement)
	end
	def destroy
		@custom_disbursement = CustomDisbursement.lumniStart(params,current_company, list: current_user.template('CustomDisbursement','custom_disbursements',current_user))
		contactCustomDisbursement = @custom_disbursement.lumniSave(params,current_user, list: current_user.template('CustomDisbursement','custom_disbursements',current_user))
		lumniClose(@cluster,contactCustomDisbursement)
	end
end