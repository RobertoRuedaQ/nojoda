class DisbursementCancellationsController < ApplicationController
	def index
		@disbursement_cancellation = DisbursementCancellation.lumniStart(params,current_company, list: current_user.template('DisbursementCancellation','disbursement_cancellations',current_user))
		contactDisbursementCancellation = @disbursement_cancellation.lumniSave(params,current_user, list: current_user.template('DisbursementCancellation','disbursement_cancellations',current_user))
		lumniClose(@disbursement_cancellation,contactDisbursementCancellation)
	end

	def new
		@disbursement_cancellation = DisbursementCancellation.lumniStart(params,current_company, list: current_user.template('DisbursementCancellation','disbursement_cancellations',current_user))
		contactDisbursementCancellation = @disbursement_cancellation.lumniSave(params,current_user, list: current_user.template('DisbursementCancellation','disbursement_cancellations',current_user))
		lumniClose(@disbursement_cancellation,contactDisbursementCancellation)
	end

	def create
		@disbursement_cancellation = DisbursementCancellation.lumniStart(params,current_company, list: current_user.template('DisbursementCancellation','disbursement_cancellations',current_user))
		contactDisbursementCancellation = @disbursement_cancellation.lumniSave(params,current_user, list: current_user.template('DisbursementCancellation','disbursement_cancellations',current_user))
		lumniClose(@disbursement_cancellation,contactDisbursementCancellation)
	end

	def edit
		@disbursement_cancellation = DisbursementCancellation.lumniStart(params,current_company, list: current_user.template('DisbursementCancellation','disbursement_cancellations',current_user))
		contactDisbursementCancellation = @disbursement_cancellation.lumniSave(params,current_user, list: current_user.template('DisbursementCancellation','disbursement_cancellations',current_user))
		lumniClose(@disbursement_cancellation,contactDisbursementCancellation)
	end

	def update
		@disbursement_cancellation = DisbursementCancellation.lumniStart(params,current_company, list: current_user.template('DisbursementCancellation','disbursement_cancellations',current_user))
		contactDisbursementCancellation = @disbursement_cancellation.lumniSave(params,current_user, list: current_user.template('DisbursementCancellation','disbursement_cancellations',current_user))
		lumniClose(@disbursement_cancellation,contactDisbursementCancellation)
	end
	def destroy
		@disbursement_cancellation = DisbursementCancellation.lumniStart(params,current_company, list: current_user.template('DisbursementCancellation','disbursement_cancellations',current_user))
		contactDisbursementCancellation = @disbursement_cancellation.lumniSave(params,current_user, list: current_user.template('DisbursementCancellation','disbursement_cancellations',current_user))
		lumniClose(@cluster,contactDisbursementCancellation)
	end
end