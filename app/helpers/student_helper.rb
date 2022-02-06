module StudentHelper
  include LumniDataStructureInformation
	def create_summary_card model, record_id
		@model = model
		@target_record = model.cached_find(record_id)
		@template = current_user.template(model.model_name.to_s,model.model_name.to_s.underscore.pluralize,current_user)
		render 'students/partial/summary_element'
	end

	def isa_status_chart_info student
		{"#{I18n.t('isa.payed_months')}" => student.active_isa.first.repayment_payed_number,
		"#{I18n.t('isa.remaining_months')}" => student.active_isa.first.payment_to_finalize_isa}

	end


	def create_student_account_body target_user, related_models,options={}
		labels = []
		objects = []
		icon_array = []
		target_models = []
		target_controllers = []
		target_render = []
		locked = []

		related_models.each do |target_object|
			target_render += ['/students/partial/general_form']
			target_models += [target_object.camelize.singularize]
			target_controllers += [target_object.underscore.pluralize]
			locked += [false]
			begin
				labels += [eval(target_models.last).model_name.human(count: 1)]
				objects += [target_user.send(target_object)]
			rescue
				labels += ['undefined']
				objects += ['undefined']
			end
			case target_object
			when 'account'
				labels[labels.count - 1] = I18n.t('form.account')
				objects[objects.count - 1] = target_user
				target_models[target_models.count - 1] = 'Student'
				target_controllers[target_controllers.count - 1] = 'students'

				icon_array += ['ion ion-md-person']
			when 'contact_info'
				icon_array += ['ion ion-md-bookmarks']
			when 'location'
				icon_array += ['ion ion-md-locate']
			when 'personal_information'
				icon_array += ['ion ion-md-paper']
			when 'student_financial_information'
				icon_array += ['fas fa-money-bill-wave']
				locked[locked.count - 1] = true
			when 'student_debt'
				objects[objects.count - 1] = target_user.student_financial_information.nil? ? nil : target_user.student_debt
				target_render[target_render.count - 1] = '/students/partial/students_debt'
				icon_array += ['fas fa-arrow-alt-circle-down']
				locked[locked.count - 1] = true
			when 'student_academic_information'
				icon_array += ['fas fa-book']
				target_render[target_render.count - 1] = '/students/partial/student_academic'
			end
		end
		related_models = related_models
		render_hash = {target_user: target_user, labels: labels, objects: objects, icon_array: icon_array,
			related_models: related_models,target_controllers: target_controllers, target_models: target_models, 
			target_render: target_render,locked: locked,options: options}

		# The following line is repeated on porpuse to allow access the information upt to two levels down in the render
		render_hash[:current_hash] = render_hash
		render_hash[:current_hash] = render_hash

		render '/students/partial/account_body', render_hash
	end


	def contract_variable_format input, classification, currency, input_id, disabled
		case classification
		when 'rate_cap','percentage_student','percentage_graduated','target_value'
			result = input.to_s + ' %'
		when 'threshold','nominal_payment','salary_cap','nominal_cap','funded_student_amount', "real_funded_amount_today"
			result = lumni_currency(input,currency)
		when 'grace_period','unemployment_months','isa_term'
			result = input.to_i
		when 'offer_due_date', 'cancelation_due_date','acceptance_date'
			result = lumni_date(input)
		when 'visible_to_student'
			result = render '/applicants/partial/option_visible',input_id: input_id, value: input, disabled: disabled
		when 'target'
			result = I18n.t('list.' + input.to_s)
		when 'dynamic_rate_cap'
			result = I18n.t('list.' + input.to_s)
		else
			result = input
		end
		return result

	end


	def funding_options_variables
		if current_user.student?
			["funded_student_amount","percentage_student", "percentage_graduated", "isa_term"]
		else
			["funded_student_amount","real_funded_amount_today","percentage_student", "percentage_graduated", "isa_term", "offer_due_date", "cancelation_due_date", "acceptance_date", "visible_to_student", "target", "target_value"]
		end
	end


	def create_team_support_table student
		fields = ['id','supervisor_name','support_name', 'actions', 'actions']
		@header = fields.map{|f| TeamSupervisor.human_attribute_name(f)}
		@rows = student.supporting_team.map{|t| [t.id, t.supervisor_name, I18n.t("support_roles.#{t.support_name}"),  link_to_edit_team_supervisor(t), link_to_remove_team_supervisor(t)]}
		render '/students/partial/supporting_team_table', student: student
	end

	def academic_template
		institution_list = {institutions: {values: [@student.funded_programs.last.institution_id],labels: [@student.funded_programs.last.institution.name]}}
		major_list = {majors: {values: [@student.funded_programs.last.major_id],labels: [@student.funded_programs.last.major.name]}}
		
		academic_template = current_user.template('StudentAcademicInformation','student_academic_informations',current_user)
		academic_template[:institution_id][:list] = institution_list
		academic_template[:major_id][:list] = major_list

		academic_template
	end

	def link_to_remove_team_supervisor(team_supervisor)
		link_to(
			I18n.t('team_supervisor.actions.remove'), 
			team_supervisor_path(team_supervisor, student_id: team_supervisor.team_member_id),  
			method: :delete,
			class: 'text-danger', 
			data: { 
				confirm: I18n.t('team_supervisor.confirm_dialog.question'), 
				commit: I18n.t('team_supervisor.confirm_dialog.commit') 
			}
		)
	end

	def link_to_edit_team_supervisor(team_supervisor)
		link_to(
			I18n.t('team_supervisor.actions.edit'),
			edit_team_supervisor_path(team_supervisor),
			remote: :true,
			class: 'text-primary',
			id: "team_supervisor_element_#{team_supervisor.id}"
		)
	end

	def link_to_new_team_supervisor
		link_to(
			I18n.t('general.new'),
			new_team_supervisor_path(),
			remote: :true,
			class: 'btn btn-primary'
		)
	end

	def financial_template
		financial_template = {}
		financial_template[:billing_to_someone_else] = {}
		financial_template[:billing_owner_rfc] = {}
		financial_template[:billing_owner_first_name] = {}
		financial_template[:billing_owner_middle_name] = {}
		financial_template[:billing_owner_last_name] = {}
		financial_template[:billing_owner_bussiness_name] = {}
		financial_template[:billing_owner_email] = {}
		financial_template[:billing_owner_address] = {}

		financial_template
	end

	def employment_status(target_user)
		status = target_user.active_isa.first.stored_employment_status
		status.nil? ? I18n.t("isa.no_information") : I18n.t("isa.#{status}")
	end

  def student_income_template
	  income_template = {}
    income_template[:id] = {} 
    income_template[:id][:controller] = 'income_informations'
    income_template[:id][:action] = 'edit'
    income_template[:id][:target_id] = 'id'
    income_template[:company_name] = {} 
    income_template[:position] = {} 
    income_template[:income_case] = {list: income_case_list} 
    income_template[:contract_case] = {list: contract_case_list} 
		income_template[:total_income] = {}
		income_template[:currency] = {}
		income_template[:income_in_local_currency] = {field_type: 'currency'} 
		income_template[:exchange_rates] = {} 
		income_template[:fix_income] = {} 
    income_template[:variable_income] = {} 
    income_template[:operations_status] = {list: operation_status_list} 
    income_template[:start_date] = {} 
    income_template[:end_date] = {} 
    income_template[:updated_at] = {} 
    income_template[:income_certificate] = {}
    income_target_fields_order = [:id, :company_name, :position, :income_case, :contract_case,:total_income, :fix_income, :variable_income, :operations_status, :start_date, :end_date, :updated_at, :income_certificate]
    income_target_fields_order.map{|f| income_template[f] = f.to_s == 'total_income'|| f.to_s == 'fix_income' || f.to_s == 'variable_income' ? {field_type: 'currency'} : income_template[f]}

    income_template
	end

	def student_collection_template(collection)
		table_template = {}
		table_template[:id] = {}
		table_template[:id][:controller] = 'collections'
		table_template[:id][:action] = 'edit'
		table_template[:id][:target_id] = 'id'
		table_template[:stage] = {}
		table_template[:contact_person] = {}
		table_template[:communication_chanel] = {}
		table_template[:action] = {}
		table_template[:case] = {}
		table_template[:result] = {}
		table_template[:following_date] = {}
		table_template[:comments] = {}
		table_template[:status] = {}
		table_template[:owner_id] = {}
		table_template[:owner_id][:list] = {options: {values:collection.map{|c| c.owner_id}, labels: collection.map{|c| c.owner_name}}}

		table_template
	end

	def student_bank_account_template
		table_template = {}

		table_template[:bank_name] = {}
		table_template[:account_number] = {}
		table_template[:name] = {}
		
		table_template
	end

	def reference_template(collection)
		template = current_user.template('Reference','references',current_user,id: true).except(:id, :user_id, :state_id, :city_id)
		template[:reference_case][:list] = {
			options: {
				values: collection.map{|c| c.reference_case}, 
				labels: collection.map{|c| c.reference_case ? I18n.t('list.' + c.reference_case) : ''}
			}
		}

		template
	end


	def course_template
		course_template = {}
		course_template[:id] = {}
		course_template[:name] = {}
		course_template[:credits] = {}
		course_template[:partial_score] = {}
		course_template[:final_score] = {}

		course_template
	end

	def student_projected_salary(target_user)
		target_user.projected_salary
	end

	def age(student)
		if student.age.nil?
			I18n.t('list.unavailable')
		else
			student.age.to_s + ' ' + I18n.t('list.years_old')
		end
	end

	def has_not_request_emergency_before?(current_user)
		current_user.application.select{ |a| a.application_case == 'black_rock_data' && (a.status == 'approved' || a.status == 'rejected')}.empty?
	end

	def has_a_valid_general_status?(current_user)
		['active', 'manual_activation', 'recovered_from_default'].include?(current_user.active_isa.first.stored_general_status)
	end


end
