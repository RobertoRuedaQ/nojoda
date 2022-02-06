class StudentAcademicInformationsController < ApplicationController
	def index
		@student_academic_information = StudentAcademicInformation.lumniStart(params,current_company, list: current_user.template('StudentAcademicInformation','student_academic_informations',current_user))
		contactStudentAcademicInformation = @student_academic_information.lumniSave(params,current_user, list: current_user.template('StudentAcademicInformation','student_academic_informations',current_user))
		lumniClose(@student_academic_information,contactStudentAcademicInformation)
	end

	def new
		@student_academic_information = StudentAcademicInformation.lumniStart(params,current_company, list: current_user.template('StudentAcademicInformation','student_academic_informations',current_user))
		contactStudentAcademicInformation = @student_academic_information.lumniSave(params,current_user, list: current_user.template('StudentAcademicInformation','student_academic_informations',current_user))
		lumniClose(@student_academic_information,contactStudentAcademicInformation)
	end

	def create
		@student_academic_information = StudentAcademicInformation.lumniStart(params,current_company, list: current_user.template('StudentAcademicInformation','student_academic_informations',current_user))
		contactStudentAcademicInformation = @student_academic_information.lumniSave(params,current_user, list: current_user.template('StudentAcademicInformation','student_academic_informations',current_user))
		lumniClose(@student_academic_information,contactStudentAcademicInformation)
	end

	def edit
		@student_academic_information = StudentAcademicInformation.lumniStart(params,current_company, list: current_user.template('StudentAcademicInformation','student_academic_informations',current_user))
		contactStudentAcademicInformation = @student_academic_information.lumniSave(params,current_user, list: current_user.template('StudentAcademicInformation','student_academic_informations',current_user))
		lumniClose(@student_academic_information,contactStudentAcademicInformation)
	end

	def update
		if params[:student_academic_information].present? && params[:student_academic_information][:isa_id].present?
			@isa = Isa.cached_find(params['student_academic_information'][:isa_id])
			target_template = helpers.academic_dates_fields
		else
			target_template = current_user.template('StudentAcademicInformation','student_academic_informations',current_user)
		end
		@student_academic_information = StudentAcademicInformation.lumniStart(params,current_company, list: target_template)
		contactStudentAcademicInformation = @student_academic_information.lumniSave(params,current_user, list: target_template, model:'student_academic_information')
		redirect_to edit_student_path(@isa.user)
	end
	
	def destroy
		@student_academic_information = StudentAcademicInformation.lumniStart(params,current_company, list: current_user.template('StudentAcademicInformation','student_academic_informations',current_user))
		contactStudentAcademicInformation = @student_academic_information.lumniSave(params,current_user, list: current_user.template('StudentAcademicInformation','student_academic_informations',current_user))
		lumniClose(@cluster,contactStudentAcademicInformation)
	end

	def edit_record
		@student_academic_information = StudentAcademicInformation.cached_find(params[:id])
		application = @student_academic_information.origination_application
		if application.nil?
			application = Application.create({status: 'active',user_id: @student_academic_information.user_id,application_case: 'funded_major',resource_type: 'StudentAcademicInformation', resource_id: @student_academic_information.id})
		end
		redirect_to edit_application_path(application)
	end

	def request_diploma_delivery
		@student_academic_information = StudentAcademicInformation.cached_find(params[:id])
		@user = @student_academic_information.user
		CommunicationMailer.request_diploma_delivery(@user.id,@user.company_id).deliver
		RequestDiplomaService.for(@user,@current_user)
		flash[:success] = I18n.t('flash.diploma_requested')
		redirect_to edit_student_path(@user)
	end

end