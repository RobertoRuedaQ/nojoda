module DashboardsHelper

  def scoring_table_template()
    scoring_template = {}
    scoring_template[:id] = {}
    scoring_template[:id][:controller] = 'applicants'
    scoring_template[:id][:action] = 'edit'
    scoring_template[:id][:target_id] = 'id'
    scoring_template[:supervisor_in_charge]= { }
    scoring_template[:fund] = {}
    scoring_template[:funding_opportunity_belongs] = {}
    scoring_template[:identification_number] = {}
    scoring_template[:first_name] = {}
    scoring_template[:last_name] = {}
    scoring_template[:email] = {}
    scoring_template[:personal_birthday] = {}
    scoring_template[:standardized_state_test_result] = {}
    scoring_template[:program_level] = {}
    scoring_template[:current_academic_status] = {}
    scoring_template[:last_period_score] = {}
    scoring_template[:number_of_disbursements_requiered] = {}
    scoring_template[:score_scale] = {}
    scoring_template[:number_subjects_failed] = {}
    scoring_template[:dependent_number] = {}
    scoring_template[:children_number] = {}
    scoring_template[:siblings_number] = {}
    scoring_template[:siblings_position] = {}
    scoring_template[:main_financial_support_person] = {}
    scoring_template[:family_living_together] = {}
    scoring_template[:child_birthday] = {}
    scoring_template[:marital_status] = {} 
    scoring_template[:city_of_recidence] = {}
    scoring_template[:city_of_study] = {}
    scoring_template[:type_of_debt] = {}
    scoring_template[:total_debt_sum] = {}
    scoring_template[:fixed_income_preloaded] = {}
    scoring_template[:variable_income_preloaded] = {}
    scoring_template[:total_application_income] = {}
    scoring_template[:total_expenses] = {}
    scoring_template[:first_reference_relationship] = {}
    scoring_template[:first_references_education_level] = {}
    scoring_template[:first_references_labor_situation] = {}
    scoring_template[:second_reference_relationship] = {}
    scoring_template[:second_references_education_level] = {}
    scoring_template[:second_references_labor_situation] = {}

    scoring_template
  end

  def applications_table_template()
    application_attributes = {}
    application_attributes[:id] = {}
    application_attributes[:id][:controller] = 'applicants'
    application_attributes[:id][:action] = 'edit'
    application_attributes[:id][:target_id] = 'id'
    application_attributes[:supervisor_in_charge]= { }
    application_attributes[:fund] = {}
    application_attributes[:funding_opportunity_belongs] = {}
    application_attributes[:email] = {}
    application_attributes[:identification_number] = {}
    application_attributes[:first_name] = {}
    application_attributes[:last_name] = {}
    application_attributes[:mobile] = {}
    application_attributes[:city_of_recidence] = {}
    application_attributes[:application_status] = {}
    application_attributes[:questionnaire_result] = {}
    application_attributes[:application_decision] = {}
    application_attributes[:application_score] = {}
    application_attributes[:major_name] = {}
    application_attributes[:institution_name] = {}
    application_attributes[:academic_level] = {}
    application_attributes[:program_number_of_terms] = {}
    application_attributes[:number_of_disbursements_requiered] = {} 
    application_attributes
  end

  def disbursement_table_template()
    disbursement_template = {}
    disbursement_template[:id] = {}
    disbursement_template[:id][:controller] = 'applications'
    disbursement_template[:id][:action] = 'edit'
    disbursement_template[:id][:target_id] = 'id'
    disbursement_template[:application_disbursement_associated_id] = {}
    disbursement_template[:application_disbursement_associated_id][:controller] = 'disbursements'
    disbursement_template[:application_disbursement_associated_id][:action] = 'edit'
    disbursement_template[:application_disbursement_associated_id][:target_id] = 'application_disbursement_associated_id'
    disbursement_template[:supervisors_in_charge] = {}
    disbursement_template[:user_name] = {}
    disbursement_template[:fund_name] = {}
    disbursement_template[:funding_opportunity_full_room] = {}
    disbursement_template[:user_identification_number] = {}
    disbursement_template[:disbursement_case] = {}
    disbursement_template[:user_email] = {}
    disbursement_template[:user_contact_number] = {}
    disbursement_template[:institution_bank_acount_number] = {}
    disbursement_template[:institution_bank_acount_account_case] = {}
    disbursement_template[:institution_bank_acount_bank_name] = {}
    disbursement_template[:user_account_number] = {}
    disbursement_template[:user_account_case] = {}
    disbursement_template[:user_bank_name] = {}
    disbursement_template[:requested_disbursement_value] = {}
    disbursement_template[:requested_disbursement_date] = {}
    disbursement_template[:real_disbursement_payment_amount] = {}
    disbursement_template[:payment_target] = {}
    disbursement_template[:status] = {}
    disbursement_template[:disbursement_payment_status] = {}
    
    disbursement_template
  end

  def disbursements_paid_in_the_month_template()
    disbursements_paid_template = {} 
    disbursements_paid_template[:id] = {}
    disbursements_paid_template[:id][:controller] = 'disbursement_payments'
    disbursements_paid_template[:id][:action] = 'edit'
    disbursements_paid_template[:id][:target_id] = 'id'
    disbursements_paid_template[:disbursement_id] = {}
    disbursements_paid_template[:disbursement_id][:controller] = 'disbursements'
    disbursements_paid_template[:disbursement_id][:action] = 'edit'
    disbursements_paid_template[:disbursement_id][:target_id] = 'disbursement_id'
    disbursements_paid_template[:fund_name] = {}
    disbursements_paid_template[:user_name] = {}
    disbursements_paid_template[:user_identification_number] = {}
    disbursements_paid_template[:status] = {}
    disbursements_paid_template[:institution_name] = {}    
    disbursements_paid_template[:payment_case] = {}
    disbursements_paid_template[:disbursement_forcasted_date] = {}
    disbursements_paid_template[:tuitition_value] = {}
    disbursements_paid_template[:value_payed_by_student] = {}
    disbursements_paid_template[:payment_target] = {}
    disbursements_paid_template[:disbursement_value] = {}
    disbursements_paid_template[:request_disbursement_date] = {}
    
    disbursements_paid_template
  end

  def billing_document_template()
    billing_document_template = {}
    billing_document_template[:id] = {}
    billing_document_template[:id][:controller] = 'billing_documents'
    billing_document_template[:id][:action] = 'edit'
    billing_document_template[:id][:target_id] = 'id'
    billing_document_template[:identification_number] = {}
    billing_document_template[:username] = {}
    billing_document_template[:fund_name] = {}
    billing_document_template[:value] = {}
    billing_document_template[:status] = {}
    billing_document_template[:due_to_date] = {}
    billing_document_template[:month] = {}
    billing_document_template[:base] = {}
    billing_document_template[:applied_value] = {}
    billing_document_template[:pending_for_payment_value] = {}
    billing_document_template[:billing_document_name] = {}
    billing_document_template[:billing_document_detail_case] = {}
    billing_document_template[:income_case] = {}
    billing_document_template[:detail_case] = {}

    billing_document_template
  end

  def payments_template
    payments_template = {}
    payments_template[:id] = {}
    payments_template[:id][:controller] = 'payments'
    payments_template[:id][:action] = 'edit'
    payments_template[:id][:target_id] = 'id'
    payments_template[:fund_name] = {}
    payments_template[:user_identification_number] = {}
    payments_template[:user] = {}
    payments_template[:bank_number] = {}
    payments_template[:description] = {}
    payments_template[:office] = {}
    payments_template[:ref_1] = {}
    payments_template[:ref_2] = {}
    payments_template[:value] = {}
    payments_template[:payment_date] = {}
    payments_template[:city_of_payment] = {}
    payments_template[:payment_source] = {}
    payments_template[:payment_method] = {}
    payments_template[:status] = {}
    payments_template[:account_case] = {}
    payments_template[:inconsistency] = {}
    payments_template[:resource_type] = {}
    payments_template[:billing_document_info] = {}
    payments_template[:billing_document_info][:controller] = 'billing_documents'
    payments_template[:billing_document_info][:action] = 'edit'
    payments_template[:billing_document_info][:target_id] = 'billing_document_info'

    payments_template
  end

  def general_information_template()
    general_template = {}
    general_template[:id] = {}
    general_template[:id][:controller] = 'students'
    general_template[:id][:action] = 'edit'
    general_template[:id][:target_id] = 'id'
    general_template[:supervisor_in_charge] = {}
    general_template[:identification_number] = {}
    general_template[:first_name] = {}
    general_template[:last_name] = {}
    general_template[:fund] = {}
    general_template[:funding_opportunity_name] = {}
    general_template[:major_name] = {}
    general_template[:academic_level] = {}
    general_template[:institution_name] = {}
    general_template[:gender] = {}
    general_template[:age] = {}
    general_template[:strata] = {}
    general_template[:ethnicity] = {}
    general_template[:indigenous_community] = {}
    general_template[:contract_case] = {}
    general_template[:origin_state] = {}
    general_template[:origin_city] = {}
    general_template[:location_state] = {}
    general_template[:location_city] = {}
    general_template[:current_academic_status] = {}
    general_template[:isa_stored_general_status] = {}
    general_template[:isa_stored_payment_status] = {}
    general_template[:isa_stored_income_status] = {}
    general_template[:stored_academic_information] = {}
    general_template[:application_result] = {}
    general_template[:current_term] = {}
    general_template[:number_of_disbursements_requiered] = {}
    general_template[:total_number_of_disbursement_tuition_payed] = {}
    general_template[:total_value_of_disbursement_tuition_payed] = {}
    general_template[:total_number_of_disbursement_living_expenses_payed] = {}
    general_template[:total_value_of_disbursement_living_expenses_payed] = {}
    general_template[:last_conection] = {}

    general_template    
  end

  def active_students_table_template()
    active_students_template = {}
    active_students_template[:id] = {}
    active_students_template[:id][:controller] = 'students'
    active_students_template[:id][:action] = 'edit'
    active_students_template[:id][:target_id] = 'id'
    active_students_template[:supervisor_in_charge]= { }
    active_students_template[:fund] = {}
    active_students_template[:funding_opportunity_belongs] = {}
    active_students_template[:identification_number] = {}
    active_students_template[:first_name] = {}
    active_students_template[:last_name] = {}
    active_students_template[:email] = {}
    active_students_template[:personal_birthday] = {}
    active_students_template[:city_of_recidence] = {}
    active_students_template[:state_of_recidence] = {}
    active_students_template[:email] = {}
    active_students_template[:institution_name] = {}
    active_students_template[:major_name] = {}
    active_students_template[:current_academic_status] = {}
    active_students_template[:mobile] = {}

    active_students_template
  end

  def projected_disbursement_template
    projected_disbursement_template = {}
    projected_disbursement_template[:id] = {}
    projected_disbursement_template[:id][:controller] = 'disbursements'
    projected_disbursement_template[:id][:action] = 'edit'
    projected_disbursement_template[:id][:target_id] = 'id'
    projected_disbursement_template[:user_supervisor_in_charge]= { }
    projected_disbursement_template[:user_fund] = {}
    projected_disbursement_template[:user_belongs_to_funding_opportunity] = {}
    projected_disbursement_template[:user_identification_number] = {}
    projected_disbursement_template[:user_first_name] = {}
    projected_disbursement_template[:user_last_name] = {}
    projected_disbursement_template[:user_email] = {}
    projected_disbursement_template[:disbursement_case] = {}
    projected_disbursement_template[:student_value] = {}
    projected_disbursement_template[:company_value] = {}
    projected_disbursement_template[:forcasted_date] = {}
    projected_disbursement_template[:institution_bank_acount_number] = {}
    projected_disbursement_template[:institution_bank_account_case] = {}
    projected_disbursement_template[:institution_bank_bank_name] = {}
    projected_disbursement_template[:user_account_number] = {}
    projected_disbursement_template[:user_account_case] = {}
    projected_disbursement_template[:user_bank_name] = {}
    projected_disbursement_template[:status] = {}

    projected_disbursement_template
  end

  def references_template
    references_template = {}
    references_template[:id] = {}
    references_template[:id][:controller] = 'applicants'
    references_template[:id][:action] = 'edit'
    references_template[:id][:target_id] = 'id'
    references_template[:supervisor_in_charge]= { }
    references_template[:fund] = {}
    references_template[:funding_opportunity_belongs] = {}
    references_template[:identification_number] = {}
    references_template[:first_name] = {}
    references_template[:last_name] = {}
    references_template[:references_first_validation_status] = {}
    references_template[:references_first_relationship] = {}
    references_template[:reference_first_first_name] = {}
    references_template[:reference_first_last_name] = {}
    references_template[:reference_first_mobile] = {}
    references_template[:reference_first_work_phone] = {}
    references_template[:reference_first_identification_number] = {}
    references_template[:reference_first_email] = {}
    references_template[:reference_first_jointly_liable] = {}

    references_template[:references_second_validation_status] = {}
    references_template[:references_second_relationship] = {}
    references_template[:reference_second_first_name] = {}
    references_template[:reference_second_last_name] = {}
    references_template[:reference_second_mobile] = {}
    references_template[:reference_second_work_phone] = {}
    references_template[:reference_second_identification_number] = {}
    references_template[:reference_second_email] = {}
    references_template[:reference_second_jointly_liable] = {}

    references_template[:references_third_validation_status] = {}
    references_template[:references_third_relationship] = {}
    references_template[:reference_third_first_name] = {}
    references_template[:reference_third_last_name] = {}
    references_template[:reference_third_mobile] = {}
    references_template[:reference_third_work_phone] = {}
    references_template[:reference_third_identification_number] = {}
    references_template[:reference_third_email] = {}
    references_template[:reference_third_jointly_liable] = {}

    references_template[:references_fourth_validation_status] = {}
    references_template[:references_fourth_relationship] = {}
    references_template[:reference_fourth_first_name] = {}
    references_template[:reference_fourth_last_name] = {}
    references_template[:reference_fourth_mobile] = {}
    references_template[:reference_fourth_work_phone] = {}
    references_template[:reference_fourth_identification_number] = {}
    references_template[:reference_fourth_email] = {}
    references_template[:reference_fourth_jointly_liable] = {}
    references_template
  end

  def employability_template
    employability_template = {}
    employability_template[:id] = {}
    employability_template[:id][:controller] = 'students'
    employability_template[:id][:action] = 'edit'
    employability_template[:id][:target_id] = 'id'
    employability_template[:supervisor_in_charge]= { }
    employability_template[:fund] = {}
    employability_template[:funding_opportunity_belongs] = {}
    employability_template[:identification_number] = {}
    employability_template[:income_percentile] = {}
    employability_template[:first_name] = {}
    employability_template[:last_name] = {}
    employability_template[:major_name] = {}
    employability_template[:institution_name] = {}
    employability_template[:isa_stored_general_status] = {}
    employability_template[:isa_stored_payment_status] = {}
    employability_template[:isa_stored_income_status] = {}
    employability_template[:stored_academic_information] = {}
    employability_template[:active_income_position] = {}
    employability_template[:active_income_company_name] = {}
    employability_template[:active_income_start_date] = {}
    employability_template[:active_income_end_date] = {}
    employability_template[:active_income_income_case] = {}
    employability_template[:active_income_contract_case] = {}
    employability_template[:active_income_currency] = {}
    employability_template[:active_income_fix_income] = {}
    employability_template[:active_income_variable_income] = {}
    employability_template[:active_income_total_income] = {}
    employability_template[:active_income_created_at] = {}
    employability_template[:active_income_updated_at] = {}

    employability_template
  end

  def grades_template
    grades_template = {}
    grades_template[:id] = {}
    grades_template[:id][:controller] = 'students'
    grades_template[:id][:action] = 'edit'
    grades_template[:id][:target_id] = 'id'
    grades_template[:fund] = {}
    grades_template[:funding_opportunity_belongs] = {}
    grades_template[:identification_number] = {}
    grades_template[:first_name] = {}
    grades_template[:last_name] = {}
    grades_template[:major_name] = {}
    grades_template[:institution_name] = {}
    grades_template[:funded_program_last_period_score] = {}
    grades_template[:average_grade_of_term] = {}
    grades_template[:university_courses_grades] = {}
    
    grades_template
  end
end