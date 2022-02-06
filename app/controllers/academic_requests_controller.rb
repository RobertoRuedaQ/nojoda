class AcademicRequestsController < ApplicationController
	def index
		@academic_request = AcademicRequest.lumniStart(params,current_company, list: current_user.template('AcademicRequest','academic_requests',current_user))
		contactAcademicRequest = @academic_request.lumniSave(params,current_user, list: current_user.template('AcademicRequest','academic_requests',current_user))
		lumniClose(@academic_request,contactAcademicRequest)
	end

	def new
		@academic_request = AcademicRequest.lumniStart(params,current_company, list: current_user.template('AcademicRequest','academic_requests',current_user))
		contactAcademicRequest = @academic_request.lumniSave(params,current_user, list: current_user.template('AcademicRequest','academic_requests',current_user))
		lumniClose(@academic_request,contactAcademicRequest)
	end

	def create
		@academic_request = AcademicRequest.lumniStart(params,current_company, list: current_user.template('AcademicRequest','academic_requests',current_user))
		contactAcademicRequest = @academic_request.lumniSave(params,current_user, list: current_user.template('AcademicRequest','academic_requests',current_user))
		lumniClose(@academic_request,contactAcademicRequest)
	end

	def edit
		@academic_request = AcademicRequest.lumniStart(params,current_company, list: current_user.template('AcademicRequest','academic_requests',current_user))
		contactAcademicRequest = @academic_request.lumniSave(params,current_user, list: current_user.template('AcademicRequest','academic_requests',current_user))
		lumniClose(@academic_request,contactAcademicRequest)
	end

	def update
		@academic_request = AcademicRequest.lumniStart(params,current_company, list: current_user.template('AcademicRequest','academic_requests',current_user))
		contactAcademicRequest = @academic_request.lumniSave(params,current_user, list: current_user.template('AcademicRequest','academic_requests',current_user))
		lumniClose(@academic_request,contactAcademicRequest)
	end
	def destroy
		@academic_request = AcademicRequest.lumniStart(params,current_company, list: current_user.template('AcademicRequest','academic_requests',current_user))
		contactAcademicRequest = @academic_request.lumniSave(params,current_user, list: current_user.template('AcademicRequest','academic_requests',current_user))
		lumniClose(@cluster,contactAcademicRequest)
	end

	def start_origination

		funded_program = StudentAcademicInformation.cached_find(params[:id])
		if !funded_program.nil? && !params[:request_case].nil?
			academic_request = AcademicRequest.joins(:application).where(applications: {status: 'active'}).find_by(student_academic_information_id: funded_program.id, request_case: params[:request_case])
			if academic_request.nil?
				academic_request = AcademicRequest.new({student_academic_information_id: funded_program.id, request_case: params[:request_case]})
			end
			if !academic_request.id.nil? || academic_request.save
				new_application = academic_request.application
				if new_application.nil?
					new_application = Application.new({resource_type: 'AcademicRequest', resource_id: academic_request.id, status: 'active',user_id: funded_program.user_id,application_case: params[:request_case]})
				end
				if new_application.save
					redirect_to edit_application_path(new_application)
				else
					redirect_to root_path
				end
			else
				redirect_to root_path
			end
		else
			redirect_to root_path
		end

	end
end