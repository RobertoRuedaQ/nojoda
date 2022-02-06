class UserQuestionnairesController < ApplicationController
	def index
		@user_questionnaire = UserQuestionnaire.lumniStart(params,current_company, list: current_user.template('UserQuestionnaire','user_questionnaires',current_user,current_company: current_company))
		contactUserQuestionnaire = @user_questionnaire.lumniSave(params,current_user, list: current_user.template('UserQuestionnaire','user_questionnaires',current_user,current_company: current_company))
		lumniClose(@user_questionnaire,contactUserQuestionnaire)
	end

	def new
		@user_questionnaire = UserQuestionnaire.lumniStart(params,current_company, list: current_user.template('UserQuestionnaire','user_questionnaires',current_user,current_company: current_company))
		contactUserQuestionnaire = @user_questionnaire.lumniSave(params,current_user, list: current_user.template('UserQuestionnaire','user_questionnaires',current_user,current_company: current_company))
		lumniClose(@user_questionnaire,contactUserQuestionnaire)
	end

	def create
		@user_questionnaire = UserQuestionnaire.lumniStart(params,current_company, list: current_user.template('UserQuestionnaire','user_questionnaires',current_user,current_company: current_company))
		contactUserQuestionnaire = @user_questionnaire.lumniSave(params,current_user, list: current_user.template('UserQuestionnaire','user_questionnaires',current_user,current_company: current_company))
		lumniClose(@user_questionnaire,contactUserQuestionnaire)
	end

	def edit
		@user_questionnaire = UserQuestionnaire.lumniStart(params,current_company, list: current_user.template('UserQuestionnaire','user_questionnaires',current_user,current_company: current_company))
		contactUserQuestionnaire = @user_questionnaire.lumniSave(params,current_user, list: current_user.template('UserQuestionnaire','user_questionnaires',current_user,current_company: current_company))
		lumniClose(@user_questionnaire,contactUserQuestionnaire)
	end

	def update
		@user_questionnaire = UserQuestionnaire.lumniStart(params,current_company, list: current_user.template('UserQuestionnaire','user_questionnaires',current_user,current_company: current_company))
		contactUserQuestionnaire = @user_questionnaire.lumniSave(params,current_user, list: current_user.template('UserQuestionnaire','user_questionnaires',current_user,current_company: current_company))
		lumniClose(@user_questionnaire,contactUserQuestionnaire)
	end
	def destroy
		@user_questionnaire = UserQuestionnaire.lumniStart(params,current_company, list: current_user.template('UserQuestionnaire','user_questionnaires',current_user,current_company: current_company))
		contactUserQuestionnaire = @user_questionnaire.lumniSave(params,current_user, list: current_user.template('UserQuestionnaire','user_questionnaires',current_user,current_company: current_company))
		lumniClose(@user_questionnaire,contactUserQuestionnaire)
	end

	def new_questionnaire_match
		@user_questionnaire = UserQuestionnaire.new(user_id: params[:id])
	end

	def get_start
		start_test
	end

	def test_taker
		@user_questionnaire = UserQuestionnaire.includes( [:questionnaire, :user_questionnaire_answer, {user_questionnaire_answer: :answer},{user_questionnaire_score: :questionnaire}, {questionnaire: :all_questions}]).cached_find(params[:id])
		@questionnaire = @user_questionnaire.questionnaire
		if (@user_questionnaire.user_id == current_user.id) || @questionnaire.category != 'selection_test' 
			if (!@user_questionnaire.end_time.nil? && @user_questionnaire.end_time < Time.now) || (@user_questionnaire.all_questions.size == @user_questionnaire.questions_anwered.size) || ['review','interview'].include?(@questionnaire.category)
				case @questionnaire.category
				when 'interview'
					@order_array = @user_questionnaire.ordered_remaining_questions[0 ... [@questionnaire.questions_per_page.to_i,1].max]
				when 'review'
					@order_array = @user_questionnaire.ordered_all_questions(@questionnaire)
				else
					@user_questionnaire.update(status: 'finished')
					redirect_to finish_test_user_questionnaire_path(@user_questionnaire)
				end
			elsif @user_questionnaire.status != 'pending' && @user_questionnaire.status != 'ongoing'
				redirect_to root_path
			else
				@order_array = @user_questionnaire.ordered_remaining_questions[0 ... [@questionnaire.questions_per_page.to_i,1].max]
			end
		else
			contactUserQuestionnaire = 'unauthorized'
			lumniClose(@user_questionnaire,contactUserQuestionnaire)
		end
	end


	def confirm_result
		@user_questionnaire = UserQuestionnaire.cached_find(params[:id])
	end	

	def start_test
		@user_questionnaire = UserQuestionnaire.cached_find(params[:id])
		# Submiting the application
		if @user_questionnaire.questionnaire.category == 'review' && @user_questionnaire.status != 'submitted'
			@user_questionnaire.application.update(status: 'submitted')

			if @user_questionnaire.status == 'active'
				# Creating following tasks
				case @user_questionnaire.application.resource_type
				when 'Disbursement'
					@task_type_title = 'disbursement_request'
					@support_role_name = 'disbursement'
				when 'FundingOpportunity'
					@task_type_title = 'investment_committee'
					@support_role_name = 'academic'
				when 'IncomeInformation'
					@task_type_title = 'income_information_check'
					@support_role_name = 'work'
				when 'Payment'
					@task_type_title = 'manual_payment_check'
					@support_role_name = 'collection'
				when 'StudentAcademicInformation'
					@task_type_title = 'academic'
					@support_role_name = 'check_update_academic_information'
				end
				if !@task_type_title.nil? && !@support_role_name.nil?
					# We need to asign supervisors to evevybody fist
					#ProjectTask.create_system_task(@support_role_name, @user_questionnaire.user, @task_type_title, record:  @user_questionnaire.application.resource)
				end
			end

		end

		# Activating the user questionnaire
		if !['ongoing','finished','submitted'].include?(@user_questionnaire.status)
			@user_questionnaire.update({status: 'ongoing',start_time: Time.zone.now,end_time: (@user_questionnaire.questionnaire.time_limit.nil? ? nil : Time.zone.now + @user_questionnaire.questionnaire.time_limit.to_i.minutes)})
		end
		# Redirecting
		if ['following_test', 'satisfaction_survey', 'initial_test', 'selection_test'].include?(@user_questionnaire.questionnaire.category)
			redirect_to test_taker_user_questionnaire_path(@user_questionnaire)
		else
			if current_user.staff?
				redirect_to test_taker_user_questionnaire_path(@user_questionnaire)
			else
				if !@user_questionnaire.application_id.nil?
					case @user_questionnaire.application.resource_type
					when 'FundingOpportunity'
						redirect_to edit_application_path(@user_questionnaire.application)
					else
						flash[:success] = I18n.t('students.application_sent')
						redirect_to root_path
					end
				end
			end
		end
	end

	def finish_test
		@user_questionnaire = UserQuestionnaire.find(params[:id])
		if @user_questionnaire.status == 'finished' || @user_questionnaire.confirmed
			selection_test? ? @user_questionnaire.update_columns(status: 'finished', end_time: Time.zone.now) : nil
			if @user_questionnaire.application_id.present?
				next_section = @user_questionnaire.application.current_section
				if !@user_questionnaire.scored? && next_section.present? && next_section.resource_type == 'Questionnaire'
					case next_section.resource.category
					when 'review'
						@user_questionnaire.score_test
						if next_section.last_section?
							redirect_to submit_application_application_path(@user_questionnaire.application_id,user_questionnaire_id: @user_questionnaire.id )
						else
							redirect_to confirm_result_user_questionnaire_path(@user_questionnaire)
						end
					when 'selection_test'
						@user_questionnaire.score_test
						@user_questionnaire.actions_after_score
						redirect_to edit_application_path(@user_questionnaire.application)
					when 'interview'
						@user_questionnaire.score_test
						redirect_to confirm_result_user_questionnaire_path(@user_questionnaire)
					else
						next_user_questionnaire = next_section.user_questionnaire_by_appplication @user_questionnaire.application
						redirect_to start_test_user_questionnaire_path(next_user_questionnaire)
					end
				else
					if current_user.staff?
						@user_questionnaire.score_test
						redirect_to confirm_result_user_questionnaire_path(@user_questionnaire)
					else
						redirect_to edit_application_path(@user_questionnaire.application)
					end
				end
			else
				redirect_to root_path
			end

		else

			redirect_to root_path
		end

	end

	def save_confirmation
		@user_questionnaire = UserQuestionnaire.cached_find(params[:id])
		@user_questionnaire.update(confirmed: true)
		@user_questionnaire.application.update(status: 'approved') unless @user_questionnaire.application.application_case == 'origination'
    @user_questionnaire.actions_after_score
    CreateRecordAsync.perform_async('user_questionnaire_follow_up', {user_questionnaire_id: @user_questionnaire.id, state: 'confirmed', resolved_at:DateTime.now, creator_id: current_user.id})
		
		
		if @user_questionnaire.approved? && @user_questionnaire.application.resource_type == 'AcademicStop'
			@user_questionnaire.application.resource.update(status: 'active')
			NotifyAcademicStopService.for(@user_questionnaire.user_id,current_user.id)
		end

		application_case = @user_questionnaire.application.application_case
		if @user_questionnaire.approved? && ['disbursement_request', 'final_scores'].include?(application_case)
			PerformServiceAsync.perform_async('StudyAcademicBonusService', @user_questionnaire.id)
		end

		if !@user_questionnaire.application_id.nil?
			application = @user_questionnaire.application

			if !@user_questionnaire.approved? && application.resource_type == 'FundingOpportunity' && application.status == 'inactive'
				@target_communication_name = 'you_did_not_approve'
			end

			if !@target_communication_name.nil?
				CommunicationMailer.general_application_communication(application.user_id, application.id, application.user.company_id, @target_communication_name).deliver
			end
		end

		redirect_to_student
	end

	def redirect_to_student
		if @user_questionnaire.user.active_student?
			redirect_to edit_student_path(@user_questionnaire.user_id)
		elsif @user_questionnaire.user.active_applicant?
			redirect_to edit_applicant_path(@user_questionnaire.user_id)
		else
			redirect_to root_path
		end
	end

	def request_correction
		@user_questionnaire = UserQuestionnaire.cached_find(params[:id])
		if !@user_questionnaire.application_id.nil?

			case @user_questionnaire.application.resource_type
			when 'Disbursement'
				@user_questionnaire.application.resource.update(status: 'requesting')
			end

			@user_questionnaire.application.update(result: nil, status: 'active', decision: nil)
			@user_questionnaire.update(status: 'active')

			requesting_modification = RequestingModification.find_by(application_id: @user_questionnaire.application_id)
			if requesting_modification.nil?
				requesting_modification = RequestingModification.new({application_id: @user_questionnaire.application_id})
			end
			requesting_modification.status = 'active'
			requesting_modification.changes_description = params[:message][:custom_message]
			requesting_modification.deadline = params[:message][:deadline]
			requesting_modification.save
			UserQuestionnaireFollowUp.create(user_questionnaire_id: @user_questionnaire.id, state: 'requesting_modifications', resolved_at:DateTime.now, creator_id: current_user.id)

			



		end

		CommunicationMailer.request_review_correction(@user_questionnaire.user_id, @user_questionnaire.user.company_id, params[:message][:custom_message]).deliver

		redirect_to_student
	end

	def cancel_test
		@user_questionnaire = UserQuestionnaire.cached_find(params[:id])
		@user_questionnaire.update(status: 'canceled')
		redirect_to root_path
	end

	def display_result
		## Used in the Student Account View		
	end


	private

	def selection_test?
		@user_questionnaire.questionnaire.category == 'selection_test'
	end
end