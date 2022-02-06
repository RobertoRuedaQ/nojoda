class MainsController < ApplicationController
	def index
		@main = Main.lumniStart(params,current_company)
		if current_user.student?
			@student = User.includes(:active_isa).find(current_user.id)
			@active_isa = @student.active_isa.first
			@black_rock_application = Application.where(user_id: current_user.id, application_case: 'black_rock_data').last
		else
			set_projects_summary
		end
		respond_to do |format|
			format.html
	        format.js
	        format.json
		end
	end

	def clear_cache
		Rails.cache.clear
	end

	def set_projects_summary 
		if params[:project_user].nil?
			@project_user_id = current_user.id
		else
			@project_user_id = params[:project_user][:target_user]
		end

		@responsable_projects = ProjectTask.includes([:project_card, :responsable, :created_by]).by_responsable(current_user.id).limit(20)
		@creator_projects = ProjectTask.includes([:project_card, :created_by]).by_creator(current_user.id).limit(20)
		 
		# @expired = ProjectTask.expired(@project_user_id)
		# @upcoming = ProjectTask.upcoming(@project_user_id)
		# @regular = ProjectTask.regular(@project_user_id)
		# @notDeadline = ProjectTask.without_deadline(@project_user_id)


		# @n_expired = ProjectTask.expired(@project_user_id).count
		# @n_upcoming = ProjectTask.upcoming(@project_user_id).count
		# @n_regular = ProjectTask.regular(@project_user_id).count
		# @n_notDeadline = ProjectTask.without_deadline(@project_user_id).count

		if params[:action] == 'set_projects_summary'
			respond_to do |format|
				format.html
		        format.js
		        format.json
			end
		end
	end


	def disbursement
		@student = User.
			includes({isa: [{funding_option: [{disbursement: [{disbursement_application: :disbursement_request}]}]}]}).
			includes({isa: [{funding_option: [{disbursement: [{processed_application: :disbursement_request}]}]}]}).
			includes({isa: [{funding_option: [{payed_disbursements: :disbursement_payment}]}]}).
			find(current_user.id)
	end

	def billing_document
		@student = Student.includes({active_isa: [{billing_document: [:income_variable_income,{billing_document_detail: [{penalties: [{payment_match: :payment}]},{payment_match: :payment}]}]}]}).find(current_user.id)
		@isa = @student.active_isa.first
	end

	def academic_information
		@student = current_user
		fund = @student.funds.first
		@university_grades = @student.funded_programs.last.university_grade.where.not(number_of_courses_taken:nil)

		@academic_cases = []

		if @student.non_graduated_programs.any?
			# if fund.course_inscription
			# 	@academic_cases += ['courses']
			# end

			# if fund.partial_scores
			# 	@academic_cases += ['partial_scores']
			# end
			if fund.final_scores
				@academic_cases += ['final_scores']
			end
			@academic_cases += ['diploma_delivery']
		end
	end

	def income_information
		@student = current_user
	end

	def complementary_activity
		@student = current_user
	end

	def social_work
		@student = current_user
	end

	def conciliation
		@isa = current_user.active_isa.first
		years = ((Time.now - 10.years).year..(Time.now - 1.year).year).to_a.reverse
		@options = {list: {years: {values: years,labels: years}},field_type: 'list',type: 'list',value: (Time.now - 1.year).year, required: true }
		@options_income = {list: {income_list: {values: current_user.income_information.ids,labels: current_user.income_information.map{|i| i.full_name}}},field_type: 'list',type: 'list', required: true}
	end

	def payment
		@student = Student.includes({active_isa: [{payments: :payment_match}]}).find(current_user.id)
		@isa = @student.active_isa.first
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

		@payments = @isa.payments.order(:payment_date)

	end


	def contact
	end

	def student_financial_information
		@student = current_user
		@student_financial_informations = @student.student_financial_information
		@student_financial_information_application = Application.where(application_case: 'student_financial_information', user_id: @student.id).last
		@bank_account_application = Application.where(application_case: 'bank_account', user_id: @student.id).last
	end

	def student_legal_documents
		@student = current_user
		@legal_matches = @student.legal_match
	end

	def novelty
		@student = current_user
		@academic_stop_application = Application.where(user_id: @student.id, application_case: 'academic_stop').last
		@fund_withdrawal_application = Application.where(user_id: @student.id, application_case: 'fund_withdrawals').last
		@financial_adjustment_application = Application.where(user_id: @student.id, application_case: 'financial_adjustments').last
	end




end
