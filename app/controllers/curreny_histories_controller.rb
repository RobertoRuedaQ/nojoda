class CurrenyHistoriesController < ApplicationController
	def index
		@curreny_history = CurrenyHistory.lumniStart(params,current_company, list: current_user.template('CurrenyHistory','curreny_histories',current_user))
		contactCurrenyHistory = @curreny_history.lumniSave(params,current_user, list: current_user.template('CurrenyHistory','curreny_histories',current_user))
		lumniClose(@curreny_history,contactCurrenyHistory)
	end

	def new
		@curreny_history = CurrenyHistory.lumniStart(params,current_company, list: current_user.template('CurrenyHistory','curreny_histories',current_user))
		contactCurrenyHistory = @curreny_history.lumniSave(params,current_user, list: current_user.template('CurrenyHistory','curreny_histories',current_user))
		lumniClose(@curreny_history,contactCurrenyHistory)
	end

	def create
		@curreny_history = CurrenyHistory.lumniStart(params,current_company, list: current_user.template('CurrenyHistory','curreny_histories',current_user))
		contactCurrenyHistory = @curreny_history.lumniSave(params,current_user, list: current_user.template('CurrenyHistory','curreny_histories',current_user))
		lumniClose(@curreny_history,contactCurrenyHistory)
	end

	def edit
		@curreny_history = CurrenyHistory.lumniStart(params,current_company, list: current_user.template('CurrenyHistory','curreny_histories',current_user))
		contactCurrenyHistory = @curreny_history.lumniSave(params,current_user, list: current_user.template('CurrenyHistory','curreny_histories',current_user))
		lumniClose(@curreny_history,contactCurrenyHistory)
	end

	def update
		@curreny_history = CurrenyHistory.lumniStart(params,current_company, list: current_user.template('CurrenyHistory','curreny_histories',current_user))
		contactCurrenyHistory = @curreny_history.lumniSave(params,current_user, list: current_user.template('CurrenyHistory','curreny_histories',current_user))
		lumniClose(@curreny_history,contactCurrenyHistory)
	end
	def destroy
		@curreny_history = CurrenyHistory.lumniStart(params,current_company, list: current_user.template('CurrenyHistory','curreny_histories',current_user))
		contactCurrenyHistory = @curreny_history.lumniSave(params,current_user, list: current_user.template('CurrenyHistory','curreny_histories',current_user))
		lumniClose(@cluster,contactCurrenyHistory)
	end
end