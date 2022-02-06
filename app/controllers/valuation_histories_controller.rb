class ValuationHistoriesController < ApplicationController
	def index
		@valuation_history = ValuationHistory.lumniStart(params,current_company, list: current_user.template('ValuationHistory','valuation_histories',current_user))
		contactValuationHistory = @valuation_history.lumniSave(params,current_user, list: current_user.template('ValuationHistory','valuation_histories',current_user))
		lumniClose(@valuation_history,contactValuationHistory)
	end

	def new
		@valuation_history = ValuationHistory.lumniStart(params,current_company, list: current_user.template('ValuationHistory','valuation_histories',current_user))
		contactValuationHistory = @valuation_history.lumniSave(params,current_user, list: current_user.template('ValuationHistory','valuation_histories',current_user))
		lumniClose(@valuation_history,contactValuationHistory)
	end

	def create
		@valuation_history = ValuationHistory.lumniStart(params,current_company, list: current_user.template('ValuationHistory','valuation_histories',current_user))
		contactValuationHistory = @valuation_history.lumniSave(params,current_user, list: current_user.template('ValuationHistory','valuation_histories',current_user))
		lumniClose(@valuation_history,contactValuationHistory)
	end

	def edit
		@valuation_history = ValuationHistory.lumniStart(params,current_company, list: current_user.template('ValuationHistory','valuation_histories',current_user))
		contactValuationHistory = @valuation_history.lumniSave(params,current_user, list: current_user.template('ValuationHistory','valuation_histories',current_user))
		lumniClose(@valuation_history,contactValuationHistory)
	end

	def update
		@valuation_history = ValuationHistory.lumniStart(params,current_company, list: current_user.template('ValuationHistory','valuation_histories',current_user))
		contactValuationHistory = @valuation_history.lumniSave(params,current_user, list: current_user.template('ValuationHistory','valuation_histories',current_user))
		lumniClose(@valuation_history,contactValuationHistory)
	end
	def destroy
		@valuation_history = ValuationHistory.lumniStart(params,current_company, list: current_user.template('ValuationHistory','valuation_histories',current_user))
		contactValuationHistory = @valuation_history.lumniSave(params,current_user, list: current_user.template('ValuationHistory','valuation_histories',current_user))
		lumniClose(@cluster,contactValuationHistory)
	end
end