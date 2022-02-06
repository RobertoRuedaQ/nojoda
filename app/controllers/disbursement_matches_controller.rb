class DisbursementMatchesController < ApplicationController
	def index
		@disbursement_match = DisbursementMatch.lumniStart(params,current_company, list: current_user.template('DisbursementMatch','disbursement_matches',current_user))
		contactDisbursementMatch = @disbursement_match.lumniSave(params,current_user, list: current_user.template('DisbursementMatch','disbursement_matches',current_user))
		lumniClose(@disbursement_match,contactDisbursementMatch)
	end

	def new
		@disbursement_match = DisbursementMatch.lumniStart(params,current_company, list: current_user.template('DisbursementMatch','disbursement_matches',current_user))
		contactDisbursementMatch = @disbursement_match.lumniSave(params,current_user, list: current_user.template('DisbursementMatch','disbursement_matches',current_user))
		lumniClose(@disbursement_match,contactDisbursementMatch)
	end

	def create
		@disbursement_match = DisbursementMatch.lumniStart(params,current_company, list: current_user.template('DisbursementMatch','disbursement_matches',current_user))
		contactDisbursementMatch = @disbursement_match.lumniSave(params,current_user, list: current_user.template('DisbursementMatch','disbursement_matches',current_user))
		lumniClose(@disbursement_match,contactDisbursementMatch)
	end

	def edit
		@disbursement_match = DisbursementMatch.lumniStart(params,current_company, list: current_user.template('DisbursementMatch','disbursement_matches',current_user))
		contactDisbursementMatch = @disbursement_match.lumniSave(params,current_user, list: current_user.template('DisbursementMatch','disbursement_matches',current_user))
		lumniClose(@disbursement_match,contactDisbursementMatch)
	end

	def update
		@disbursement_match = DisbursementMatch.lumniStart(params,current_company, list: current_user.template('DisbursementMatch','disbursement_matches',current_user))
		contactDisbursementMatch = @disbursement_match.lumniSave(params,current_user, list: current_user.template('DisbursementMatch','disbursement_matches',current_user))
		lumniClose(@disbursement_match,contactDisbursementMatch)
	end
	def destroy
		@disbursement_match = DisbursementMatch.lumniStart(params,current_company, list: current_user.template('DisbursementMatch','disbursement_matches',current_user))
		contactDisbursementMatch = @disbursement_match.lumniSave(params,current_user, list: current_user.template('DisbursementMatch','disbursement_matches',current_user))
		lumniClose(@cluster,contactDisbursementMatch)
	end
end