class StudentExpensesController < ApplicationController
	def index
		@student_expense = StudentExpense.lumniStart(params,current_company, list: current_user.template('StudentExpense','student_expenses',current_user))
		contactStudentExpense = @student_expense.lumniSave(params,current_user, list: current_user.template('StudentExpense','student_expenses',current_user))
		lumniClose(@student_expense,contactStudentExpense)
	end

	def new
		@student_expense = StudentExpense.lumniStart(params,current_company, list: current_user.template('StudentExpense','student_expenses',current_user))
		contactStudentExpense = @student_expense.lumniSave(params,current_user, list: current_user.template('StudentExpense','student_expenses',current_user))
		lumniClose(@student_expense,contactStudentExpense)
	end

	def create
		@student_expense = StudentExpense.lumniStart(params,current_company, list: current_user.template('StudentExpense','student_expenses',current_user))
		contactStudentExpense = @student_expense.lumniSave(params,current_user, list: current_user.template('StudentExpense','student_expenses',current_user))
		lumniClose(@student_expense,contactStudentExpense)
	end

	def edit
		@student_expense = StudentExpense.lumniStart(params,current_company, list: current_user.template('StudentExpense','student_expenses',current_user))
		contactStudentExpense = @student_expense.lumniSave(params,current_user, list: current_user.template('StudentExpense','student_expenses',current_user))
		lumniClose(@student_expense,contactStudentExpense)
	end

	def update
		@student_expense = StudentExpense.lumniStart(params,current_company, list: current_user.template('StudentExpense','student_expenses',current_user))
		contactStudentExpense = @student_expense.lumniSave(params,current_user, list: current_user.template('StudentExpense','student_expenses',current_user))
		lumniClose(@student_expense,contactStudentExpense)
	end
	def destroy
		@student_expense = StudentExpense.lumniStart(params,current_company, list: current_user.template('StudentExpense','student_expenses',current_user))
		contactStudentExpense = @student_expense.lumniSave(params,current_user, list: current_user.template('StudentExpense','student_expenses',current_user))
		lumniClose(@cluster,contactStudentExpense)
	end
end