class StudentFinancialInformationsController < ApplicationController
	def index
		@student_financial_information = StudentFinancialInformation.lumniStart(params,current_company, list: current_user.template('StudentFinancialInformation','student_financial_informations',current_user))
		contactStudentFinancialInformation = @student_financial_information.lumniSave(params,current_user, list: current_user.template('StudentFinancialInformation','student_financial_informations',current_user))
		lumniClose(@student_financial_information,contactStudentFinancialInformation)
	end

	def new
		@student_financial_information = StudentFinancialInformation.lumniStart(params,current_company, list: current_user.template('StudentFinancialInformation','student_financial_informations',current_user))
		contactStudentFinancialInformation = @student_financial_information.lumniSave(params,current_user, list: current_user.template('StudentFinancialInformation','student_financial_informations',current_user))
		lumniClose(@student_financial_information,contactStudentFinancialInformation)
	end

	def create
		@student_financial_information = StudentFinancialInformation.lumniStart(params,current_company, list: current_user.template('StudentFinancialInformation','student_financial_informations',current_user))
		contactStudentFinancialInformation = @student_financial_information.lumniSave(params,current_user, list: current_user.template('StudentFinancialInformation','student_financial_informations',current_user))
		lumniClose(@student_financial_information,contactStudentFinancialInformation)
	end

	def edit
		@student_financial_information = StudentFinancialInformation.lumniStart(params,current_company, list: current_user.template('StudentFinancialInformation','student_financial_informations',current_user))
		contactStudentFinancialInformation = @student_financial_information.lumniSave(params,current_user, list: current_user.template('StudentFinancialInformation','student_financial_informations',current_user))
		lumniClose(@student_financial_information,contactStudentFinancialInformation)
	end

	def update
		@student_financial_information = StudentFinancialInformation.lumniStart(params,current_company, list: current_user.template('StudentFinancialInformation','student_financial_informations',current_user))
		contactStudentFinancialInformation = @student_financial_information.lumniSave(params,current_user, list: current_user.template('StudentFinancialInformation','student_financial_informations',current_user))
		lumniClose(@student_financial_information,contactStudentFinancialInformation)
	end
	def destroy
		@student_financial_information = StudentFinancialInformation.lumniStart(params,current_company, list: current_user.template('StudentFinancialInformation','student_financial_informations',current_user))
		contactStudentFinancialInformation = @student_financial_information.lumniSave(params,current_user, list: current_user.template('StudentFinancialInformation','student_financial_informations',current_user))
		lumniClose(@cluster,contactStudentFinancialInformation)
	end

	def create_application
    application = Application.joins(user: :student_financial_information).where(application_case: 'student_financial_information', status: 'active').where(student_financial_informations: {user_id: current_user.id}).first
    if application.nil?
      @student_financial_information = StudentFinancialInformation.create(user_id: current_user.id)
      application = Application.new({status: 'active',user_id: current_user.id,application_case: 'student_financial_information',resource_type: 'StudentFinancialInformation', resource_id: @student_financial_information.id})
      if application.save
        redirect_to edit_application_path(application)
      else
        redirect_to root_path
      end
    else
      redirect_to edit_application_path(application)
    end
  end
end