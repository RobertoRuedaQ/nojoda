class StudentDebtsController < ApplicationController
	before_action :set_income_dependencies, only: %i(edit create_application_debt)
	
	def index
		@student_debt = StudentDebt.lumniStart(params,current_company, list: current_user.template('StudentDebt','student_debts',current_user))
		contactStudentDebt = @student_debt.lumniSave(params,current_user, list: current_user.template('StudentDebt','student_debts',current_user))
		lumniClose(@student_debt,contactStudentDebt)
	end

	def new
		@student_debt = StudentDebt.lumniStart(params,current_company, list: current_user.template('StudentDebt','student_debts',current_user))
		contactStudentDebt = @student_debt.lumniSave(params,current_user, list: current_user.template('StudentDebt','student_debts',current_user))
		lumniClose(@student_debt,contactStudentDebt)
	end

	def create
		@student_debt = StudentDebt.lumniStart(params,current_company, list: current_user.template('StudentDebt','student_debts',current_user))
		contactStudentDebt = @student_debt.lumniSave(params,current_user, list: current_user.template('StudentDebt','student_debts',current_user))
		lumniClose(@student_debt,contactStudentDebt)
	end

	def edit
		@student_debt = StudentDebt.lumniStart(params,current_company, list: current_user.template('StudentDebt','student_debts',current_user))
		contactStudentDebt = @student_debt.lumniSave(params,current_user, list: current_user.template('StudentDebt','student_debts',current_user))
		lumniClose(@student_debt,contactStudentDebt)
	end

	def update
		@student_debt = StudentDebt.lumniStart(params,current_company, list: current_user.template('StudentDebt','student_debts',current_user))
		contactStudentDebt = @student_debt.lumniSave(params,current_user, list: current_user.template('StudentDebt','student_debts',current_user))
		lumniClose(@student_debt,contactStudentDebt)
	end
	def destroy
		@student_debt = StudentDebt.lumniStart(params,current_company, list: current_user.template('StudentDebt','student_debts',current_user))
		contactStudentDebt = @student_debt.lumniSave(params,current_user, list: current_user.template('StudentDebt','student_debts',current_user))
		lumniClose(@cluster,contactStudentDebt)
	end

	def create_application_debt
		template = OriginationSection.cached_find(params[:temp][:section]).cached_form_template.template_hash( current_user, current_company)
		@student_debt = StudentDebt.create(permit_application_params(template))
	end

private
	def permit_application_params template
		params.require(:studentdebt).permit(template.keys)
	end

	def set_income_dependencies
		return unless params[:temp]

		@hidden_fields = params.require(:temp).permit(
			:application_id, :section, :target_module
		).to_h || {}    
		@application = Application.find(@hidden_fields['application_id'])
		@section = OriginationSection.find(@hidden_fields['section'])
	end
end
