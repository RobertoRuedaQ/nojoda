class CreditHistoryChecksController < ApplicationController
	def index
		@credit_history_check = CreditHistoryCheck.lumniStart(params,current_company, list: current_user.template('CreditHistoryCheck','credit_history_checks',current_user))
		contactCreditHistoryCheck = @credit_history_check.lumniSave(params,current_user, list: current_user.template('CreditHistoryCheck','credit_history_checks',current_user))
		lumniClose(@credit_history_check,contactCreditHistoryCheck)
	end

	def new
		@credit_history_check = CreditHistoryCheck.lumniStart(params,current_company, list: current_user.template('CreditHistoryCheck','credit_history_checks',current_user))
		contactCreditHistoryCheck = @credit_history_check.lumniSave(params,current_user, list: current_user.template('CreditHistoryCheck','credit_history_checks',current_user))
		lumniClose(@credit_history_check,contactCreditHistoryCheck)
	end

	def create
		@credit_history_check = CreditHistoryCheck.lumniStart(params,current_company, list: current_user.template('CreditHistoryCheck','credit_history_checks',current_user))
		contactCreditHistoryCheck = @credit_history_check.lumniSave(params,current_user, list: current_user.template('CreditHistoryCheck','credit_history_checks',current_user))
		lumniClose(@credit_history_check,contactCreditHistoryCheck)
	end

	def edit
		@credit_history_check = CreditHistoryCheck.lumniStart(params,current_company, list: current_user.template('CreditHistoryCheck','credit_history_checks',current_user))
		contactCreditHistoryCheck = @credit_history_check.lumniSave(params,current_user, list: current_user.template('CreditHistoryCheck','credit_history_checks',current_user))
		lumniClose(@credit_history_check,contactCreditHistoryCheck)
	end

	def update
		@credit_history_check = CreditHistoryCheck.lumniStart(params,current_company, list: current_user.template('CreditHistoryCheck','credit_history_checks',current_user))
		contactCreditHistoryCheck = @credit_history_check.lumniSave(params,current_user, list: current_user.template('CreditHistoryCheck','credit_history_checks',current_user))
		lumniClose(@credit_history_check,contactCreditHistoryCheck)
	end
	def destroy
		@credit_history_check = CreditHistoryCheck.lumniStart(params,current_company, list: current_user.template('CreditHistoryCheck','credit_history_checks',current_user))
		contactCreditHistoryCheck = @credit_history_check.lumniSave(params,current_user, list: current_user.template('CreditHistoryCheck','credit_history_checks',current_user))
		lumniClose(@cluster,contactCreditHistoryCheck)
	end
end