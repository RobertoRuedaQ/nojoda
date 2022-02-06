class StudentsController < ApplicationController

	def index

		@general_status_options = Isa.general_status_options
		if params[:general_status].nil?
			@current_general_status = Isa.active_for_collection
		else
			@current_general_status = params[:general_status]
		end

		@funds = Fund.where(company_id: current_company.my_companies.ids)
		if !params[:funding_opportunities].nil?
			@funding_opportunities = FundingOpportunity.joins(fund: :company).where(funds: {id: params[:funds]})
			@funding_opportunity_ids = params[:funding_opportunities]
			@fund_ids = params[:funds]
		elsif !params[:funds].nil?
			@funding_opportunities = FundingOpportunity.joins(fund: :company).where(funds: {id: params[:funds]})
			@funding_opportunity_ids = FundingOpportunity.where(fund_id: params[:funds]).ids
			@fund_ids = params[:funds]
		else
			@funding_opportunities = FundingOpportunity.joins(fund: :company).where(funds: {companies: {id: current_company.my_companies.ids}})
			@funding_opportunity_ids = @funding_opportunities.ids
		end

		if current_user.team_profile_id == 1
			@student = Student.by_isa_general_status(@current_general_status).by_funding_opportunity(@funding_opportunity_ids).from_company(current_company.my_companies.ids).limit(2000).distinct
		else
			@student = Student.my_students(current_user.fullTeam).by_isa_general_status(@current_general_status).by_funding_opportunity(@funding_opportunity_ids).from_company(current_company.my_companies.ids).limit(2000).distinct
		end



		if params[:funding_opportunities].nil? 
			@funding_opportunity_ids = nil
		end

		if params[:funds].nil?
			@fund_ids = nil
		end


		studentResult = @student.lumniSave(params,current_user)
		lumniClose(@student,studentResult)
	end

	def new
		@student = Student.lumniStart(params,current_company)
		studentResult = @student.lumniSave(params,current_user)
		lumniClose(@student,studentResult)
	end

	def create
		@student = Student.lumniStart(params,current_company)
		@student.type_of_account = 'student'
		studentResult = @student.lumniSave(params,current_user)
		lumniClose(@student,studentResult)
	end

	def edit
		@student = Student.includes({active_isa: [{billing_document: [:income_variable_income,{billing_document_detail: :penalties}]}]}).find(params[:id])
		studentResult = @student.lumniSave(params,current_user)
		lumniClose(@student,studentResult)
	end

	def update
		@student = Student.lumniStart(params,current_company)
		studentResult = @student.lumniSave(params,current_user)
		lumniClose(@student,studentResult)
	end
	def destroy
		@student = Student.lumniStart(params,current_company)
		studentResult = @student.lumniSave(params,current_user)
		lumniClose(@student,studentResult)
	end

	def simulate_student
		@student = User.find_by_email(params[:temp][:email])

		if !@student.nil?
			temp_account = current_user.id
		    sign_in(:user, @student)
		    session[:original_account] = temp_account
		    redirect_to root_url # or user_root_url
		else
			redirect_to root_path
		end
	end

	def filter_students
		if params[:lumni_filter].nil?
			redirect_to students_path
		else
			redirect_to students_path(funding_opportunities: params[:lumni_filter][:funding_opportunities],
				funds: params[:lumni_filter][:funds],
				general_status: params[:lumni_filter][:general_status])
		end
	end

	def set_funding_opportunity_filter
		@funding_opportunities = FundingOpportunity.joins(fund: :company).where(funds: {id: params[:funds]})
	end


	def full
		@student = Student.includes({active_isa: [{billing_document: [:income_variable_income,{billing_document_detail: [{penalties: [{payment_match: :payment}]},{payment_match: :payment}]}]}]}).
			includes({isa: [{funding_option: [{disbursement: :disbursement_match}]}]}).
			includes({isa: [{funding_option: [{disbursement: :disbursement_payment}]}]}).
			includes({isa: [{funding_option: [{disbursement: :disbursement_cancellation}]}]}).
			includes({isa: [{funding_option: [{application: :original_application}]}]}).
			includes({isa: [{funding_option: [{disbursement: [{disbursement_application: :disbursement_request}]}]}]}).
			includes({isa: [{funding_option: [{disbursement: [{processed_application: :disbursement_request}]}]}]}).
			includes({isa: [{funding_option: [{payed_disbursements: :disbursement_payment}]}]}).
			includes({isa: [{funding_opportunity: :fund}]}).
			includes(:collection,:complementary_activity,:contact_info,:application,:reference,:team_profile,:social_work).
			includes({projects: [{project_card: [{project_task: :checklist}]}]}).
			find(params[:id])
		params[:action] = 'edit'
		studentResult = @student.lumniSave(params,current_user)
		lumniClose(@student,studentResult)

	end

	def management
		@student = Student.includes(:collection,:contact_info).
			find(params[:id])
		params[:action] = 'edit'
		studentResult = @student.lumniSave(params,current_user)
		lumniClose(@student,studentResult)
	end

	def project
		@student = Student.includes({projects: [{project_card: [{project_task: :checklist}]}]}).
			find(params[:id])
		params[:action] = 'edit'
		studentResult = @student.lumniSave(params,current_user)
		lumniClose(@student,studentResult)
	end

	def communications
		@student = Student.find(params[:id])
		params[:action] = 'edit'
		studentResult = @student.lumniSave(params,current_user)
		lumniClose(@student,studentResult)
	end

	def workshops
		@student = Student.includes(:complementary_activity,:contact_info).
			find(params[:id])
		params[:action] = 'edit'
		studentResult = @student.lumniSave(params,current_user)
		lumniClose(@student,studentResult)
	end

	def support_team
		@student = Student.find(params[:id])
		params[:action] = 'edit'
		studentResult = @student.lumniSave(params,current_user)
		lumniClose(@student,studentResult)
	end

	def financial_information
		@student = Student.find(params[:id])
		params[:action] = 'edit'
		studentResult = @student.lumniSave(params,current_user)
		lumniClose(@student,studentResult)
	end


	def academic_info
		@student = Student.includes(:student_academic_information).find(params[:id])
		@university_grades = @student.funded_programs.last.university_grade.where.not(number_of_courses_taken:nil)
		params[:action] = 'edit'
		studentResult = @student.lumniSave(params,current_user)
		lumniClose(@student,studentResult)
	end

	def social_service
		@student = Student.includes(:social_work).
			find(params[:id])
		params[:action] = 'edit'
		studentResult = @student.lumniSave(params,current_user)
		lumniClose(@student,studentResult)
	end

	def contract_amendment
		@student = Student.find(params[:id])
		params[:action] = 'edit'
		studentResult = @student.lumniSave(params,current_user)
		lumniClose(@student,studentResult)
	end

	def conciliation
		@student = Student.includes(:conciliation_information).find(params[:id])
		params[:action] = 'edit'
		studentResult = @student.lumniSave(params,current_user)
		lumniClose(@student,studentResult)
	end

	def payment
		@student = Student.includes(active_isa: :payments).find(params[:id])
		params[:action] = 'edit'
		studentResult = @student.lumniSave(params,current_user)
		@payments = @student.active_isa.first.payments

		payment_options = ["PaymentAgreement", "PaymentMassDoc", "PayuResponse"]
		@payment_template = {id: {},
							payment_date: {},
							value: {}, 
							resource_type: {
								list: {options: {
									values: payment_options,
									labels: payment_options.map{|p| I18n.t("mains.#{p}")}
								}}
							}}
		lumniClose(@student,studentResult)
	end

	def application
		@student = Student.find(params[:id])
		params[:action] = 'edit'
		studentResult = @student.lumniSave(params,current_user)
		@application_template = { 	id: {},
									updated_at: {}
								}




		lumniClose(@student,studentResult)
	end

	def legal_documents
		@student = Student.find(params[:id])
		@target_application = @student.application.select{|a| a.application_case == 'origination'}.first
		params[:action] = 'edit'
		studentResult = @student.lumniSave(params,current_user)
		lumniClose(@student,studentResult)
	end


	def create_application
    application = Application.where(application_case: 'students_data', status: 'active').where(user_id: current_user.id).first
    if application.nil?
      @student_data = User.find(current_user.id)
      application = Application.new({status: 'active',user_id: current_user.id,application_case: 'students_data',resource_type: 'Student', resource_id: @student_data.id})
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
