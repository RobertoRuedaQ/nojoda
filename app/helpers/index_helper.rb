module IndexHelper
	def application_components_index
		list = {}
		list[:id] = {}
		list[:funding_opportunity_id] = {}
		list[:process_id] = {}
		list[:reference_id] = {}
		list[:reference_type] = {}
		return list
	end

	def applications_index
		list = {}
		list[:id] = {}
		list[:created_at] = {}
		list[:updated_at] = {}
		list[:t_status] = {}
		return list
	end
	def approval_archive_index
		list = {}
		list[:id] = {}
		list[:request_user_name] = {}
		list[:respond_user_name] = {}
		list[:approval_target] = {}
		list[:approval_action] = {}
		list[:state] = {}
		list[:requested_at] = {}
		return list
	end
	def approval_managers_index
		list = {}
		list[:id] = {}
		list[:request_user_name] = {}
		list[:respond_user_name] = {}
		list[:approval_target] = {}
		list[:approval_action] = {}
		list[:state] = {}
		list[:requested_at] = {}
		return list
	end
	def approval_matches_index
		list = {}
		list[:id] = {}
		list[:user_id] = {}
		list[:role_id] = {}
		list[:approver_id] = {}
		list[:approver_role] = {}
		return list
	end
	def clusters_index
		list = {}
		list[:id] = {}
		list[:cluster_case] = {}
		list[:value] = {}
		list[:major_id] = {}
		return list
	end
	def companies_index
		list = {}
		list[:id] = {}
		list[:name] = {}
		list[:status] = {}
		list[:url] = {}
		list[:default_language] = {}
		return list
	end
	def contact_infos_index
		list = {}
		list[:id] = {}
		list[:area_code] = {}
		list[:phone] = {}
		list[:extension_number] = {}
		list[:mobile] = {}
		list[:other_phone] = {}
		list[:email] = {}
		list[:secondary_email] = {}
		list[:resource_type] = {}
		list[:resource_id] = {}
		return list
	end
	def countries_index
		list = {}
		list[:id] = {}
		list[:name] = {}
		list[:currency] = {}
		return list
	end
	def funding_opportunities_index
		list = {}
		list[:id] = {}
		list[:name] = {}
		list[:fund_name] = {}
		list[:fund_name] = {}
		list[:t_status] = {}
		list[:start_date] = {}
		list[:close_date] = {}
		return list
	end
	def funds_index
		list = {}
		list[:id] = {}
		list[:name] = {}
		list[:parent_fund] = {}
		list[:active] = {}
		list[:close_day] = {}
		list[:start_date] = {}
		list[:close_date] = {}
		list[:extension_periods] = {}
		return list
	end
	def history_index
		list = {}
		list[:version] = {}
		list[:created_at] = {}
		list[:action] = {}
		list[:audited_changes] = {}
		list[:user] = {}
		return list
	end
	def home_index
		list = {}
		list[:id] = {}
		return list
	end
	def institutions_index
		list = {}
		list[:id] = {}
		list[:name] = {}
		list[:status] = {}
		list[:code] = {}
		list[:website] = {}
		return list
	end
	def legal_documents_index
		list = {}
		list[:id] = {}
		list[:name] = {}
		list[:document_type] = {}
		list[:status] = {}
		list[:language] = {}
		return list
	end
	def legal_matches_index
		list = {}
		list[:id] = {}
		list[:user] = {}
		list[:legal_documents] = {}
		list[:validation_method] = {}
		list[:validation] = {}
		list[:answer] = {}
		list[:body] = {}
		return list
	end
	def mains_index
		list = {}
		list[:id] = {}
		return list
	end
	def majors_index
		list = {}
		list[:id] = {}
		list[:name] = {}
		list[:academic_level] = {}
		list[:status] = {}
		list[:institution_id] = {}
		return list
	end

	def ipcs_index
		list = {}
		list[:id] = {}
		list[:country_name] = {}
		list[:year] = {}
		list[:month] = {}
		list[:value] = {}
		list[:monthly_variation] = {}
		list[:annual_variation] = {}
		list[:cumulative_variation] = {}
	
		return list
	end

	def migrations_index
		list = {}
		list[:id] = {}
		list[:fund] = {}
		list[:result] = {}
		list[:notes] = {}
		list[:company_id] = {}
		list[:new_fund_name] = {}
		return list
	end
	def personal_informations_index
		list = {}
		list[:id] = {}
		list[:birthday] = {}
		list[:marital_status] = {}
		list[:gender] = {}
		list[:document_type] = {}
		list[:identification_number] = {}
		list[:user_id] = {}
		return list
	end
	def pricing_details_index
		list = {}
		list[:id] = {}
		list[:case] = {}
		list[:min] = {}
		list[:max] = {}
		list[:percentage] = {}
		list[:initial_income_cap] = {}
		list[:cash_reserves_needed] = {}
		list[:exit_year] = {}
		list[:pricing_table_id] = {}
		return list
	end
	def pricing_vectors_index
		list = {}
		list[:id] = {}
		list[:pricing_table_id] = {}
		list[:salary] = {}
		list[:repayment] = {}
		list[:service] = {}
		return list
	end
	def pricing_tables_index
		list = {}
		list[:id] = {}
		list[:institutions_id] = {}
		list[:funding_opportunities_id] = {}
		list[:grade_level] = {}
		list[:cluster] = {}
		list[:isa_length] = {}
		list[:real_cap] = {}
		list[:reference_value] = {}
		list[:periodicity] = {}
		return list
	end
	def profiles_index
		list = {}
		list[:id] = {}
		return list
	end
	def roles_index
		list = {}
		list[:id] = {}
		list[:name] = {}
		return list
	end
	def students_index
		list = {}
		list[:id] = {}
		list[:identification_number] = {}
		list[:first_name] = {}
		list[:last_name] = {}
		list[:email] = {}
		return list
	end
	def teams_index
		list = {}
		list[:id] = {}
		list[:first_name] = {}
		list[:last_name] = {}
		list[:status] = {}
		list[:email] = {}
		list[:company_name] = {}
		return list
	end
	def trashes_index
		list = {}
		list[:id] = {}
		return list
	end

	def questionnaires_index
		list = {}
		list[:id] = {}
		list[:name] = {}
		list[:max_score] = {}
		list[:min_approval_score] = {}
		return list
	end


	def projects_index
		list = {}
		list[:id] = {}
		list[:title] = {}
		return list
	end

	def task_types_index
		list = {}
		list[:id] = {}
		list[:title] = {}
		list[:description] = {}
		list[:functionality] = {}
		return list
	end
	def communication_templates_index
		list = {}
		list[:id] = {}
		list[:title] = {}
		list[:case_name] = {}
		list[:language] = {}
		return list
	end

	def communication_cases_index
		list = {}
		list[:id] = {}
		list[:title] = {required: true}
		list[:description] = {required: true}
		return list
	end
	def communication_headers_index
		list = {}
		list[:id] = {}
		list[:title] = {required: true}
		return list
	end

	def communication_footers_index
		list = {}
		list[:id] = {}
		list[:title] = {required: true}
		return list
	end

	def main_tasks_index
		list = {}
		list[:project_title] = {controller: 'projects',action: 'edit',target_id: 'project_id'}
		list[:title] = {}
		list[:main_task_name] = {}
		list[:description] = {}
		list[:deadline] = {}
		list[:created_at] = {}

		return list
	end

	def team_profiles_index
		list = {}
		list[:id] = {}
		list[:name] = {required: true}
		list[:description] = {}
		return list
	end

	def form_templates_index
		list = {}
		list[:id] = {}
		list[:name] = {required: true}
		list[:object] = {}
		return list
	end

	def form_lists_index
		list = {}
		list[:id] = {}
		list[:case] = {required: true}
		list[:user_label] = {}
		return list
	end

	def form_attributes_index
		list = {}
		list[:id] = {}
		list[:name] = {}
		list[:value]
		return list

	end
end


