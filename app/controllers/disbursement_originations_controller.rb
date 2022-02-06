class DisbursementOriginationsController < ApplicationController
	def index
		@disbursement_origination = DisbursementOrigination.lumniStart(params,current_company, list: current_user.template('DisbursementOrigination','disbursement_originations',current_user))
		contactDisbursementOrigination = @disbursement_origination.lumniSave(params,current_user, list: current_user.template('DisbursementOrigination','disbursement_originations',current_user))
		lumniClose(@disbursement_origination,contactDisbursementOrigination)
	end

	def new
		@disbursement_origination = DisbursementOrigination.lumniStart(params,current_company, list: current_user.template('DisbursementOrigination','disbursement_originations',current_user))
		contactDisbursementOrigination = @disbursement_origination.lumniSave(params,current_user, list: current_user.template('DisbursementOrigination','disbursement_originations',current_user))
		lumniClose(@disbursement_origination,contactDisbursementOrigination)
	end

	def create
		@disbursement_origination = DisbursementOrigination.lumniStart(params,current_company, list: current_user.template('DisbursementOrigination','disbursement_originations',current_user))
		contactDisbursementOrigination = @disbursement_origination.lumniSave(params,current_user, list: current_user.template('DisbursementOrigination','disbursement_originations',current_user))
		lumniClose(@disbursement_origination,contactDisbursementOrigination)
	end

	def edit
		@disbursement_origination = DisbursementOrigination.lumniStart(params,current_company, list: current_user.template('DisbursementOrigination','disbursement_originations',current_user))
		contactDisbursementOrigination = @disbursement_origination.lumniSave(params,current_user, list: current_user.template('DisbursementOrigination','disbursement_originations',current_user))
		lumniClose(@disbursement_origination,contactDisbursementOrigination)
	end

	def update
		@disbursement_origination = DisbursementOrigination.lumniStart(params,current_company, list: current_user.template('DisbursementOrigination','disbursement_originations',current_user))
		contactDisbursementOrigination = @disbursement_origination.lumniSave(params,current_user, list: current_user.template('DisbursementOrigination','disbursement_originations',current_user))
		lumniClose(@disbursement_origination,contactDisbursementOrigination)
	end
	def destroy
		@disbursement_origination = DisbursementOrigination.lumniStart(params,current_company, list: current_user.template('DisbursementOrigination','disbursement_originations',current_user))
		contactDisbursementOrigination = @disbursement_origination.lumniSave(params,current_user, list: current_user.template('DisbursementOrigination','disbursement_originations',current_user))
		lumniClose(@cluster,contactDisbursementOrigination)
	end
end