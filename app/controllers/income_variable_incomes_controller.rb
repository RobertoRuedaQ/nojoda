class IncomeVariableIncomesController < ApplicationController
	def index
		@income_variable_income = IncomeVariableIncome.lumniStart(params,current_company, list: current_user.template('IncomeVariableIncome','income_variable_incomes',current_user))
		contactIncomeVariableIncome = @income_variable_income.lumniSave(params,current_user, list: current_user.template('IncomeVariableIncome','income_variable_incomes',current_user))
		lumniClose(@income_variable_income,contactIncomeVariableIncome)
	end

	def new
		@income_variable_income = IncomeVariableIncome.lumniStart(params,current_company, list: current_user.template('IncomeVariableIncome','income_variable_incomes',current_user))
		contactIncomeVariableIncome = @income_variable_income.lumniSave(params,current_user, list: current_user.template('IncomeVariableIncome','income_variable_incomes',current_user))
		lumniClose(@income_variable_income,contactIncomeVariableIncome)
	end

	def create
		@income_variable_income = IncomeVariableIncome.lumniStart(params,current_company, list: current_user.template('IncomeVariableIncome','income_variable_incomes',current_user))
		contactIncomeVariableIncome = @income_variable_income.lumniSave(params,current_user, list: current_user.template('IncomeVariableIncome','income_variable_incomes',current_user))
		lumniClose(@income_variable_income,contactIncomeVariableIncome)
	end

	def edit
		@income_variable_income = IncomeVariableIncome.lumniStart(params,current_company, list: current_user.template('IncomeVariableIncome','income_variable_incomes',current_user))
		contactIncomeVariableIncome = @income_variable_income.lumniSave(params,current_user, list: current_user.template('IncomeVariableIncome','income_variable_incomes',current_user))
		lumniClose(@income_variable_income,contactIncomeVariableIncome)
	end

	def update
		@income_variable_income = IncomeVariableIncome.lumniStart(params,current_company, list: current_user.template('IncomeVariableIncome','income_variable_incomes',current_user))
		contactIncomeVariableIncome = @income_variable_income.lumniSave(params,current_user, list: current_user.template('IncomeVariableIncome','income_variable_incomes',current_user))
		lumniClose(@income_variable_income,contactIncomeVariableIncome)
	end
	def destroy
		@income_variable_income = IncomeVariableIncome.lumniStart(params,current_company, list: current_user.template('IncomeVariableIncome','income_variable_incomes',current_user))
		contactIncomeVariableIncome = @income_variable_income.lumniSave(params,current_user, list: current_user.template('IncomeVariableIncome','income_variable_incomes',current_user))
		lumniClose(@cluster,contactIncomeVariableIncome)
	end


	def update_variable_income
		@income_variable_income = IncomeVariableIncome.cached_find(params[:id])
		if @income_variable_income.income_information.variable_income.to_f <= params[:incomevariableincome][:value].to_f || current_user.staff?
			@income_variable_income.update_attributes(params_simple_update)
		else
			@income_variable_income.update(status: 'under_review')
			@income_variable_income.value = params[:incomevariableincome][:value].to_f
			request = current_user.request_for_update(@income_variable_income,reason: 'student_request_update_variable_income')
		end
		
		if current_user.staff?
			redirect_to edit_student_path(@income_variable_income.billing_document.user)
		else
			redirect_to @income_variable_income.billing_document
		end

	end

private
	def params_simple_update
		params.require(:incomevariableincome).permit(:value)
	end


end