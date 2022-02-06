class ApplicationsController < ApplicationController
  include Pundit
  protect_from_forgery
  include LumniApplicationForms
  include LumniDisbursement
  include LumniModeling

	def index
		if current_user.student?
			@application = Application.where(user_id: current_user.id,resource_type: "FundingOpportunity")
		else
			application_ids = Application.select(:id).joins(:user, user_questionnaire: :questionnaire).where(user_questionnaires: {status: ['active','ongoing']}).where(user_questionnaire: { questionnaires:{category: 'review'}}).where(status: 'submitted').where(users: {company_id: current_company.my_companies.ids}).distinct
			application_query = Application.preload(:resource).includes(:active_questionnaire, :funding_opportunity, {disbursement_request: :pending_changes},{user: [funded_programs: :institution, reporting_to: :supervisor]}).where(id: application_ids).order(created_at: :desc)
			@application_cases = application_query.map(&:application_case).uniq
			@application_ransack = application_query.ransack(params[:q])
			@application =  @application_ransack.result.paginate(page: params[:page], per_page: records_per_page)
		end
		applicationResult = @application.lumniSave(params,current_user,list: current_user.template('Application','applications',current_user,current_company: current_company))
		lumniClose(@application,applicationResult)
	end

	def new
		@application = Application.lumniStart(params,current_company,list: current_user.template('Application','applications',current_user,current_company: current_company))
		applicationResult = @application.lumniSave(params,current_user,list: current_user.template('Application','applications',current_user,current_company: current_company))
		lumniClose(@application,applicationResult)
	end

	def create

		@application = Application.lumniStart(params,current_company,list: current_user.template('Application','applications',current_user,current_company: current_company))
		applicationResult = @application.lumniSave(params,current_user,list: current_user.template('Application','applications',current_user,current_company: current_company))
		lumniClose(@application,applicationResult)
	end

	def edit
		@application = Application.full_application.lumniStart(params,current_company,list: current_user.template('Application','applications',current_user,current_company: current_company))
		@modules =  @application.resource_type == "Isa" ? @application.original_application.resource.cached_modules_and_sections : @application.resource.cached_modules_and_sections
		applicationResult = @application.lumniSave(params,current_user,list: current_user.template('Application','applications',current_user,current_company: current_company))
		@full_student = User.full_student.cached_find(@application.user_id)
		lumniClose(@application,applicationResult)
		@object_title = @full_student.name
	end

	def update
		@application = Application.lumniStart(params,current_company,list: current_user.template('Application','applications',current_user,current_company: current_company))
		applicationResult = @application.lumniSave(params,current_user,list: current_user.template('Application','applications',current_user,current_company: current_company))
		lumniClose(@application,applicationResult)
	end
	def destroy
		@application = Application.lumniStart(params,current_company,list: current_user.template('Application','applications',current_user,current_company: current_company))
		@user = @application.user
		@user.flush_commit_cache
		applicationResult = @application.discard
		redirect_to edit_applicant_path(@user)
	end


	def approve_isa_amendment
		begin
			@application = Application.find(params[:id])
			#check if student had have an ammendment previusly
			if @application.original_application.funding_option.selected.first.original_option_id.nil?
				isa = @application.original_application.funding_option.selected.first.isa
			end
			if isa.nil?
				isa = @application.original_application.user.active_isa.first
			end
			funding_option = @application.funding_option.selected.first
			funding_option.update_column('original_option_id', isa.funding_option.id)
			isa.update(funding_option_id: funding_option.id)
			if @application.typology != 'blackrock'
				funding_option.funding_option_disbursement.includes(:disbursement).each do |f_disbursement|
					if f_disbursement.evaluation_value.present? && f_disbursement.evaluation_value > 0 && f_disbursement.disbursement.student_value != f_disbursement.evaluation_value
						f_disbursement.disbursement.update_column('company_value',f_disbursement.evaluation_value)
						f_disbursement.update_column('evaluation_value',nil)
						f_disbursement.disbursement.update_column('student_value', f_disbursement.disbursement.adjusted_student_value)
					end
				end
			end
			if @application.typology == 'mentory_empleability'
				PerformServiceAsync.perform_async('MentoryEmpleabilityDisbursementService', @application.id)
			end
			@application.update_column('status', 'approved')
		rescue StandardError => error
			logger.error(error.message)
		end
		redirect_to edit_student_path(@application.user)
	end

	def reject_isa_amendment
		@application = Application.find(params[:id])
		@application.update(status: 'rejected')
		redirect_to edit_student_path(@application.user)
	end

	def storing_application_info
		if params[:temp].nil?
			@application_id = params[:application_id]
			@section_id = params[:section]
			@check_section = params[:check_section]
			@save_check = params[:save]
		else
			@application_id = params[:temp][:application_id]
			@section_id = params[:temp][:section]
			@check_section = params[:temp][:check_section]
			@save_check = params[:temp][:save]
		end


		@application = Application.full_application.cached_find(@application_id)
		initial_module = @application.current_module_number
		final_module_number = @application.final_module_number
		
		@full_student = User.full_student.cached_find(@application.user_id)
		@section = OriginationSection.cached_find(@section_id)
		if @save_check.nil? || @save_check == 'true'
			@target_record = eval("applicationForm#{@section.resource.object}(@section,@full_student,@application)")
			if @section.review
				@target_record.attributes = params_application_user(@section.resource)
				request = current_user.request_for_update(@target_record,reason: 'application update')
				request.save
				@target_record.flush_commit_cache
			else
				@target_record.update(params_application_user(@section.resource))
			end
		end
		##application_follow_up by section
		stage = (@section.alternative_label.nil? || @section.alternative_label == '') ? eval(@section.cached_form_template.object).model_name.human(count: 1) : @section.alternative_label
		ApplicationFollowUp.create(application_id: @application.id, stage: stage  )
		
		if @check_section != 'stop'
			ApplicationSectionTrack.create(application_id: @application.id,origination_section_id: @section.id)
			@application.update(step: @section.origination_module.origination.current_step(@application))

			@module_next = initial_module != @application.current_module_number
		end
	end

	def submit_application
		@application = Application.cached_find(params[:id])
		if @application.update(status: 'submitted')
			if !@application.task_by_type('submit_application').nil?
				submit_application_task = @application.task_by_type('submit_application').parent
				submit_application_task.make_all_done
			end

			if !@application.questionnaire_pending_review.nil?
				@application.questionnaire_pending_review.update(status: 'ongoing')
			end


			if current_company.automatic_proposal_display
				@application.update(show_financial_proposals: true)
			end
			if @application.resource_type == 'FundingOpportunity'
				modeling_students( @application)
			end
		end

		if current_user.staff?
			if params[:user_questionnaire_id].nil?
				redirect_to edit_applicant_path(@application.user_id)
			else
				redirect_to confirm_result_user_questionnaire_path(params[:user_questionnaire_id])
			end
		else
			redirect_to root_path
		end
	end

	def creating_record
		@section = OriginationSection.includes(:resource,resource: :child).cached_find(params[:temp][:section])
		template = @section.resource
		new_record = eval(template.object).new(params_application_user(template))
		puts "new_record: #{new_record.attributes}"
		if new_record.save
			puts 'creating child info'
			if !template.child_id.nil? && !template.child_foreign_key.nil?
				child_new = eval(template.child.object).new(params_application_user(template.child))
				child_new[template['child_foreign_key']] = new_record.id
				child_new.save
			end
		end
		redirect_to edit_application_path(params[:temp][:application_id])
	end






	def edit_record
		@section = OriginationSection.includes(:resource, resource: :child).cached_find(params[:section])
		@application = Application.cached_find(params[:application_id])
		@hidden_fields = {section: params[:section], application: params[:application_id], target_module: params[:target_module]}

		if @section.resource.child_id.nil? && @section.resource.child_foreign_key.nil?
			@target_record = eval("#{@section.resource.object}.cached_find(#{params[:id]})")
		else
			@target_record = eval("#{@section.resource.object}.includes(:#{@section.resource.child.object.underscore}).cached_find(#{params[:id]})")
		end

	end


	def update_record
		@section = OriginationSection.includes(:resource,resource: :child).cached_find(params[:temp][:section])
		template = @section.resource
		new_record = eval(template.object).new(params_application_user(template))
		if new_record.save
			if !template.child_id.nil? && @section.resource.child_foreign_key.nil?
				child_new = eval(template.child.object).new(params_application_user(template.child))
				child_new[template['child_foreign_key']] = new_record.id
				child_new.save
			end
		end
		redirect_to edit_application_path(params[:temp][:application_id])
	end

	def load_target_modules
		@modules = OriginationModule.where(id: params[:modules])
		@application = Application.cached_find(params[:application])
		@full_student = User.full_student.cached_find(@application.user_id)
	end

	def set_disbursements
		application = Application.cached_find(params[:application])
		@funding_disbursement = application.funding_opportunity.funding_disbursement
		modeling = application.funding_opportunity.modeling
		if modeling.custom_disbursements.any?
			@disbursements_hash = disbursement_custom_hash( modeling, application.user_id, application.resource_id)
		else
			@disbursements_hash = disbursement_hash params[:periodicity], params[:disbursement_date], params[:disbursement_number], params[:disbursement_value],params[:living_expenses_check], @funding_disbursement
		end
	end

	def set_show_financial_proposals
		@application = Application.cached_find(params[:id])
		@application.update({show_financial_proposals: params[:show_financial_proposals]})
	end


	def approve_changes
		target_record = eval("#{params[:model]}.cached_find(#{params[:target_id]})")
		target_record.attributes = helpers.translate_approval_input(target_record)
		if target_record.save
			target_requests = Approval::Request.where(id: target_record.pending_changes.map{|i| i.request_id}  )
			target_requests.each do |request|
				request.lock!
				request.comments.create(user_id: current_user.id, content: 'application review approve')
        request.update({state: :approved, approved_at: Time.current, respond_user_id: current_user.id})
			end
		end

		redirect_to test_taker_user_questionnaire_path(params[:questionnaire])


	end

	def reject_changes
		user_questionnaire = UserQuestionnaire.find(params[:questionnaire])
		target_record = eval("#{params[:model]}.cached_find(#{params[:target_id]})")
		target_record.pending_requests.each do |item|
			request = item.request
			request.lock!
			request.comments.create(user_id: user_questionnaire.user_id, content: 'rejected by auditing')
	        request.update({state: :rejected, rejected_at: Time.current, respond_user_id: current_user.id})
#			target_record.reject_request(item.request, reason: "rejection from application review")
		end

		redirect_to test_taker_user_questionnaire_path(params[:questionnaire])

	end

	def reactivate_application
    application = Application.cached_find(params[:id])

    application.funding_option.map(&:fast_destroy)
    application.invalid_funding_option.map(&:fast_destroy)

    application.update(
      {
        status: 'active',
        show_financial_proposals: false,
        decision: nil,
        result: nil,
      },
    )
    questionnaire =
      application
        .user_questionnaire
        .joins(:questionnaire)
        .where(questionnaires: { category: 'review' })
    questionnaire.update_all(status: 'active') if questionnaire.count > 0
    redirect_to edit_applicant_path(application.user_id)
  end

  def reactivate_regular_application
    application = Application.cached_find(params[:id])
    #validate if the is a disbursement request not payed yet.
    if application.resource_type == 'Disbursement'
      disbursement = application.resource

      # if payed, redirect & notify SM is not possible to continue.
      if disbursement.disbursement_payment.present? &&
           disbursement.disbursement_payment.first.status == 'payed'
        flash[:danger] =
          I18n.t(
            'students.flash.application.not_possible_disbursement',
            application_id: application.id,
            disbursement_id: disbursement.id
          )
        redirect_to edit_applicant_path(application.user_id)
				return
      else
        #if not payed yet, delete all disbursement match and reactivate disbursement
        application.resource.disbursement_match.destroy_all
        application.resource.update(
          status: 'active',
          stored_general_status: 'active',
        )
      end
    end

    #reactivate application & all the associated user_questionnaires.
    application.update({ status: 'active', decision: nil, result: nil })
    questionnaire =
      application
        .user_questionnaire
        .joins(:questionnaire)
        .where(questionnaires: { category: 'review' })
    if questionnaire.size > 0
      questionnaire.update_all(status: 'active', confirmed: nil)
    end

    #redirect & notify
    flash[:success] =
      I18n.t(
        'students.flash.application.reactivated',
        application_id: application.id,
      )
    redirect_to edit_applicant_path(application.user_id)
  end

  def change_disbursement_request
    disbursement_request = DisbursementRequest.find(params[:id])

    redirect_to edit_disbursement_request_path(disbursement_request)
  end

  private

  def params_application_user(template)
    permited_keys = template.template_hash(current_user, current_company).keys
    permited_required = eval(template.object).model_name.to_s.downcase.to_sym
    if %w[student profile applicant].include?(permited_required.to_s) &&
         params.keys.map(&:to_s).include?('user')
      intersection = permited_keys & params[:user].keys.map(&:to_sym)
      intersection.map do |key|
        params[permited_required][key] = params[:user][key]
      end
    end

    multiple_fields = @target_record.class.active_storage_fields_has_many

    permited_keys.each do |temp_key|
      if multiple_fields.include? temp_key.to_s
        permited_keys.delete(temp_key)
        unless params[permited_required][temp_key] == ['']
          permited_keys << { "#{temp_key}": [] }
        end
      end
    end

    params[permited_required].keys.each do |temp_key|
      if params[permited_required][temp_key] == ''
        params[permited_required] = params[permited_required].except(temp_key)
      elsif params[permited_required][temp_key].is_a? Array
        if temp_key == 'people_living_together'
          params[permited_required][temp_key] =
            params[permited_required][temp_key].join(';')
        else
          params[permited_required][temp_key] =
            params[permited_required][temp_key]
        end
      end
    end
    params.require(permited_required).permit(permited_keys)
  end

  def records_per_page
    return 25 if params[:per_page].nil?

    params[:per_page]
  end
end
