class ApplicantsController < ApplicationController
	def index
		@funding_opportunities = FundingOpportunity.joins(:fund).where(funds: {company_id: current_company.my_companies.ids})
		@funding_opportunity_list = {options: {values: @funding_opportunities.ids, labels: @funding_opportunities.pluck(:name)}}
#		@applicant = Applicant.includes(:application).my_students(current_user.id).lumniStart(params,current_company, list: current_user.template('Applicant','applicants',current_user))
		if params[:funding_opportunity_id].present?
			@applicant = Applicant.includes(ongoing_application: :funding_opportunity).active_applicats.
				where(ongoing_applications: {funding_opportunities: {id: params[:funding_opportunity_id]}})
			contactApplicant = @applicant.lumniSave(params,current_user, list: current_user.template('Applicant','applicants',current_user))
			lumniClose(@applicant,contactApplicant)
		end
	end

	def search_applicants
		redirect_to applicants_path(funding_opportunity_id: params[:funding_opportunity][:name])
	end

	def new
		@applicant = Applicant.includes(:application).lumniStart(params,current_company, list: current_user.template('Applicant','applicants',current_user))
		contactApplicant = @applicant.lumniSave(params,current_user, list: current_user.template('Applicant','applicants',current_user))
		lumniClose(@applicant,contactApplicant)
	end

	def create
		@applicant = Applicant.includes(:application).lumniStart(params,current_company, list: current_user.template('Applicant','applicants',current_user))
		contactApplicant = @applicant.lumniSave(params,current_user, list: current_user.template('Applicant','applicants',current_user))
		lumniClose(@applicant,contactApplicant)
	end

	def edit
		@applicant = Applicant.includes(:application).lumniStart(params,current_company, list: current_user.template('Applicant','applicants',current_user))
		contactApplicant = @applicant.lumniSave(params,current_user, list: current_user.template('Applicant','applicants',current_user))
		lumniClose(@applicant,contactApplicant)
		@user_questionnaires = UserQuestionnaire.includes(:questionnaire, :questionnaire_exception).joins(origination_section: [origination_module: :origination]).where('originations.discarded_at IS NULL AND origination_modules.discarded_at IS NULL AND origination_sections.discarded_at IS NULL').distinct.kept.where(user_id: @applicant.id)

		@application = @applicant.current_application
		@legal_matches = @applicant.legal_match.includes(:legal_document, :scanned_document_attachment)
		header_fields = ['id','application_case', 'status', 'last_change_by', 'last_change_at','funding_opportunity_name','step','destroy', 'reactivate'] 

		@application_headers = header_fields.map{|h| Application.human_attribute_name(h)}
		@application_rows = []
		application = @applicant.application.includes([:funding_opportunity, :user, :resource, :questionnaire_review])
		application.each do |application|
			@application_rows += [header_fields.map{|h| helpers.translate_application_table_at_applicant(h,application)}]
		end

		@application_withdrawn = ApplicationFollowUp.new
	end

	def refresh_modeling
		@applicant = Applicant.find(params[:id])
		@application = @applicant.current_application
		@application.funding_option.update_all(model_status: 'deleating')
		ModelClassesAsync.perform_async('Application', 'modeling', @application.id)
		redirect_to edit_applicant_path(@applicant)
	end

	def withdrawn_application
		@application_withdrawn = ApplicationFollowUp.new
		@applicant = Applicant.find(params[:id])
		@application = Application.find(params[:applicationfollowup][:application_id])
		@application.update(status: 'withdrawn')
		@application_withdrawn.update(stage:params[:applicationfollowup][:stage], application_id: params[:applicationfollowup][:application_id] )
		redirect_to edit_applicant_path(@applicant)
	end


	def update
		@applicant = Applicant.includes(:application).lumniStart(params,current_company, list: current_user.template('Applicant','applicants',current_user))
		contactApplicant = @applicant.lumniSave(params,current_user, list: current_user.template('Applicant','applicants',current_user))
		lumniClose(@applicant,contactApplicant)
	end
	def destroy
		@applicant = Applicant.includes(:application).lumniStart(params,current_company, list: current_user.template('Applicant','applicants',current_user))
		contactApplicant = @applicant.lumniSave(params,current_user, list: current_user.template('Applicant','applicants',current_user))
		lumniClose(@cluster,contactApplicant)
	end

	def project
		@applicant = Applicant.includes({projects: [{project_card: [{project_task: :checklist}]}]}).
			find(params[:id])
		params[:action] = 'edit'
		applicantResult = @applicant.lumniSave(params,current_user)
		lumniClose(@applicant,applicantResult)
	end

	def communications
		@applicant = Applicant.find(params[:id])
		params[:action] = 'edit'
		applicantResult = @applicant.lumniSave(params,current_user)
		lumniClose(@applicant,applicantResult)
	end

end