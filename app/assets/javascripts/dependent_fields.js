$(document).on('turbolinks:load',function () {
	if(location.href.split('/').pop() != 'test_taker'){
		setAllDependentFields()
	}
})


function manage_dependent_fields(main_id, dependent_id,array_visible_value,reverse=false){

  $('[id^='+ main_id +']').not('.switcher-input').each(function(){
    manage_visibility_fields(this,dependent_id,array_visible_value,false,reverse)
  })

  $('[id^='+ main_id +']').not('.switcher-input').on('change',function(){
    manage_visibility_fields(this,dependent_id,array_visible_value,true,reverse)
  })

}

function manage_visibility_fields(target_element,dependent_id,array_visible_value,highlight,reverse){

  target_id = target_element.id.split('_').pop()
  temp_dependent_id = '#' + dependent_id + target_id
  
  if($(temp_dependent_id).length > 0 && location.href.split('/')[3] != 'form_templates' && location.href.split('/')[3] != 'user_questionnaires'){

    original_values = $(target_element).val()
    if(Array.isArray(original_values)){
      array_current_values = original_values
    }else{
      array_current_values = original_values.split(';')
    }

    if(reverse){
	    visible_validation = !(array_visible_value.filter(value => array_current_values.includes(value)).length > 0)
    }else{
	    visible_validation = array_visible_value.filter(value => array_current_values.includes(value)).length > 0
    }

    if(visible_validation){
      if(typeof $(temp_dependent_id).attr('temp_required') != 'undefined'){
        if($(temp_dependent_id).attr('temp_required') == 'true'){
          $(temp_dependent_id).attr('required','required')
        }
      }
      $('#form_group-' + dependent_id + target_id).show()
      if(highlight){
        $('#form_group-' + dependent_id + target_id).addClass('new-comment')
      }
    }else{
      $('#form_group-' + dependent_id + target_id).hide()
      $('#form_group-' + dependent_id + target_id).removeClass('new-comment')
    	
      if(typeof $(temp_dependent_id).attr('required') != 'undefined'){
        $(temp_dependent_id).attr('temp_required','true')
        $(temp_dependent_id).removeAttr('required')
      }else{
        $(temp_dependent_id).attr('temp_required','false')
      }
      $(temp_dependent_id).val('').trigger('change')
      if($(temp_dependent_id + 'numericField').length > 0){
        $(temp_dependent_id + 'numericField').val('')
      }

    }
  }
}


function setAllDependentFields(){
	manage_dependent_fields('fundingopportunity_include_promissory_note_','fundingopportunity_adult_promissory_note_id_',['true'])
	manage_dependent_fields('fundingopportunity_include_promissory_note_','fundingopportunity_young_promissory_note_id_',['true'])
	manage_dependent_fields('sociodemographic_people_living_together_','sociodemographic_other_people_living_together_',['other'])
	manage_dependent_fields('sociodemographic_social_program_check_','sociodemographic_social_program_text_',['true'])
	manage_dependent_fields('sociodemographic_social_program_text_','sociodemographic_social_program_other_',['other'])
	manage_dependent_fields('studentacademicinformation_institution_id_','studentacademicinformation_other_institution_text_',['75442'])
	manage_dependent_fields('studentacademicinformation_standardized_state_test_check_','studentacademicinformation_standardized_state_test_result_',['true'])
	manage_dependent_fields('studentacademicinformation_standardized_state_test_check_','studentacademicinformation_standardized_state_test_date_',['true'])
	manage_dependent_fields('studentacademicinformation_ackn_scholarship_check_','studentacademicinformation_ackn_scholarship_text_',['true'])
	manage_dependent_fields('schoolinfo_problem_at_school_check_','schoolinfo_problem_at_school_text_',['true'])
	manage_dependent_fields('schoolinfo_school_year_failed_check_','schoolinfo_school_year_failed_text_',['true'])
	manage_dependent_fields('studentacademicinformation_finished_major_check_','studentacademicinformation_egress_date_',['true'])
	manage_dependent_fields('studentacademicinformation_finished_major_check_','studentacademicinformation_graduation_date_',['true'])
	manage_dependent_fields('studentacademicinformation_finished_major_check_','studentacademicinformation_expected_graduation_date_',['false',''])
	manage_dependent_fields('studentacademicinformation_finished_major_check_','studentacademicinformation_current_term_',['false',''])
	manage_dependent_fields('universityinfo_problems_with_subjects_check_','universityinfo_problems_with_subjects_text_',['true'])

	manage_dependent_fields('mentoryempleabilityinvitation_accept_invitation_','mentoryempleabilityinvitation_empleability_',['true'])
	manage_dependent_fields('mentoryempleabilityinvitation_accept_invitation_','mentoryempleabilityinvitation_mentory_',['true'])

	manage_dependent_fields('studentfinancialinformation_what_is_your_income_source_','studentfinancialinformation_family_support_value_',['family_support'])
	manage_dependent_fields('studentfinancialinformation_what_is_your_income_source_','studentfinancialinformation_family_support_frequency_',['family_support'])

	manage_dependent_fields('studentfinancialinformation_what_is_your_income_source_','studentfinancialinformation_other_people_value_',['other_people'])
	manage_dependent_fields('studentfinancialinformation_what_is_your_income_source_','studentfinancialinformation_personal_business_value_',['personal_business'])
	manage_dependent_fields('studentfinancialinformation_what_is_your_income_source_','studentfinancialinformation_federal_aid_value_',['federal_aid'])
	manage_dependent_fields('studentfinancialinformation_what_is_your_income_source_','studentfinancialinformation_temporal_work_value_',['temporal_work'])
	manage_dependent_fields('studentfinancialinformation_what_is_your_income_source_','studentfinancialinformation_full_time_employ_value_',['full_time_employ'])
	manage_dependent_fields('studentfinancialinformation_what_is_your_income_source_','studentfinancialinformation_partial_time_employ_value_',['partial_time_employ'])
	manage_dependent_fields('studentfinancialinformation_what_is_your_income_source_','studentfinancialinformation_other_people_frequency_',['other_people'])
	manage_dependent_fields('studentfinancialinformation_what_is_your_income_source_','studentfinancialinformation_personal_business_frequency_',['personal_business'])
	manage_dependent_fields('studentfinancialinformation_what_is_your_income_source_','studentfinancialinformation_federal_aid_frequency_',['federal_aid'])
	manage_dependent_fields('studentfinancialinformation_what_is_your_income_source_','studentfinancialinformation_temporal_work_frequency_',['temporal_work'])
	manage_dependent_fields('studentfinancialinformation_what_is_your_income_source_','studentfinancialinformation_full_time_employ_frequency_',['full_time_employ'])
	manage_dependent_fields('studentfinancialinformation_what_is_your_income_source_','studentfinancialinformation_partial_time_employ_frequency_',['partial_time_employ'])

	manage_dependent_fields('studentfinancialinformation_do_you_have_savings_','studentfinancialinformation_savings_value_',['true'])
	manage_dependent_fields('health_disability_check_','health_disability_text_',['true'])
	manage_dependent_fields('health_diseases_check_','health_diseases_text_',['true'])
	manage_dependent_fields('health_diseases_text_','health_diseases_other_',['OTHER'])
	manage_dependent_fields('studentacademicinformation_funding_need_','studentacademicinformation_number_of_disbursements_requiered_',['true'])
	manage_dependent_fields('studentacademicinformation_funding_need_','studentacademicinformation_disbursements_periodicity_',['true'])
	manage_dependent_fields('studentacademicinformation_funding_need_','studentacademicinformation_first_disbursement_date_',['true'])
	manage_dependent_fields('studentacademicinformation_funding_need_','studentacademicinformation_disbursement_value_',['true'])
	manage_dependent_fields('studentacademicinformation_funding_need_','studentacademicinformation_finished_major_check_',['false'])
	manage_dependent_fields('studentfinancialinformation_what_is_your_income_source_','studentfinancialinformation_do_you_have_family_economical_support_',['family_support'])
	manage_dependent_fields('reference_labor_situation_','reference_unemployment_months_',['unemployed'])
	manage_dependent_fields('reference_labor_situation_','reference_company_',['independent','employee'])
	manage_dependent_fields('reference_labor_situation_','reference_occupation_',['independent','employee'])
	manage_dependent_fields('reference_labor_situation_','reference_work_address_',['independent','employee'])
	manage_dependent_fields('reference_labor_situation_','reference_work_phone_',['independent','employee'])
	manage_dependent_fields('reference_labor_situation_','reference_total_income_',['independent','employee','retired','pensioner','housewife', 'freelancer', 'entrepreneur'])	
	
	manage_dependent_fields('incomeinformation_income_case_','incomeinformation_contact_name_', ['employment'])
	manage_dependent_fields('incomeinformation_income_case_','incomeinformation_contact_phone_', ['employment'])
	manage_dependent_fields('incomeinformation_income_case_','incomeinformation_contract_case_', ['employment'])
	manage_dependent_fields('incomeinformation_income_case_','incomeinformation_contact_email_', ['employment'])
	manage_dependent_fields('incomeinformation_income_case_','incomeinformation_email_supervisor_', ['employment'])
	manage_dependent_fields('incomeinformation_income_case_','incomeinformation_name_supervisor_', ['employment'])
	manage_dependent_fields('incomeinformation_income_case_','incomeinformation_position_supervisor_', ['employment'])
	manage_dependent_fields('incomeinformation_income_case_','incomeinformation_company_address_', ['employment'])
	manage_dependent_fields('incomeinformation_income_case_','incomeinformation_company_phone_', ['employment'])
	manage_dependent_fields('incomeinformation_income_case_','incomeinformation_shift_', ['employment'])
	manage_dependent_fields('incomeinformation_income_case_','incomeinformation_company_identification_', ['employment'])
	manage_dependent_fields('incomeinformation_income_case_','incomeinformation_phone_supervisor_', ['employment'])
	manage_dependent_fields('incomeinformation_income_case_','incomeinformation_active_check_', ['employment'])
	manage_dependent_fields('incomeinformation_income_case_','incomeinformation_job_pool_', ['employment'])
	manage_dependent_fields('incomeinformation_income_case_','incomeinformation_tier_', ['employment', 'entrepreneurship', 'freelancer'])
	manage_dependent_fields('incomeinformation_income_case_','incomeinformation_area_', ['employment','informal_employment', 'entrepreneurship', 'freelancer'])
	manage_dependent_fields('incomeinformation_income_case_','incomeinformation_company_name_', ['employment', 'entrepreneurship'])
	manage_dependent_fields('incomeinformation_income_case_','incomeinformation_position_', ['employment', 'entrepreneurship'])
	manage_dependent_fields('incomeinformation_income_case_','incomeinformation_type_of_labor_', ['informal_employment'])
	manage_dependent_fields('incomeinformation_income_case_','incomeinformation_income_certificate_', ['employment', 'entrepreneurship', 'freelancer'])


	manage_dependent_fields('studentfinancialinformation_what_is_your_income_source_','studentfinancialinformation_partial_time_employ_frequency_',['partial_time_employ'])
	manage_dependent_fields('studentacademicinformation_finished_major_check_','studentacademicinformation_graduation_certificate_',['true'])
	manage_dependent_fields('studentacademicinformation_current_term_','studentacademicinformation_grade_certificate_',['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15'])
	manage_dependent_fields('reference_jointly_liable_','reference_credit_check_autoreport_',['true'])
	manage_dependent_fields('reference_jointly_liable_','reference_reference_work_certificate_',['true'])
	manage_dependent_fields('reference_jointly_liable_','reference_identification_document_image_',['true'])
	manage_dependent_fields('health_health_coverage_','health_health_coverage_certificate_',['Ninguna'],true)
	manage_dependent_fields('studentacademicinformation_standardized_state_test_check_','studentacademicinformation_standardized_state_test_result_',['true'])
	manage_dependent_fields('studentacademicinformation_standardized_state_test_check_','studentacademicinformation_standardized_state_test_date_',['true'])
	manage_dependent_fields('studentacademicinformation_standardized_state_test_check_','studentacademicinformation_standardized_state_test_ranking_',['true'])
	manage_dependent_fields('reference_guardian_','reference_dentification_document_image_',['true'])	
	manage_dependent_fields('infoterpel_applicant_case_','infoterpel_company_name_',['son_of_islero','touch_ store_attendant_son'])
	manage_dependent_fields('infoterpel_applicant_case_','infoterpel_position_',['son_of_islero','touch_ store_attendant_son'])
	manage_dependent_fields('infoterpel_applicant_case_','infoterpel_contract_case_',['son_of_islero','touch_ store_attendant_son'])
	manage_dependent_fields('infoterpel_applicant_case_','infoterpel_start_date_',['son_of_islero','touch_ store_attendant_son'])
	manage_dependent_fields('infoterpel_applicant_case_','infoterpel_fix_income_',['son_of_islero','touch_ store_attendant_son'])
	manage_dependent_fields('infoterpel_applicant_case_','infoterpel_end_date_',['son_of_islero','touch_ store_attendant_son'])
	manage_dependent_fields('infoterpel_applicant_case_','infoterpel_shift_',['son_of_islero','touch_ store_attendant_son'])
	manage_dependent_fields('infoterpel_applicant_case_','infoterpel_email_supervisor_',['son_of_islero','touch_ store_attendant_son'])
	manage_dependent_fields('infoterpel_applicant_case_','infoterpel_name_supervisor_',['son_of_islero','touch_ store_attendant_son'])
	manage_dependent_fields('infoterpel_applicant_case_','infoterpel_position_supervisor_',['son_of_islero','touch_ store_attendant_son'])


	manage_dependent_fields('infoterpel_applicant_case_','infoterpel_company_phone_',['son_of_islero','touch_ store_attendant_son'])
	manage_dependent_fields('infoterpel_applicant_case_','infoterpel_relationship_',['son_of_islero','touch_ store_attendant_son'])



	manage_dependent_fields('reference_guardian_','reference_guardian_',['true'])	

	manage_dependent_fields('bankaccount_resource_type_','bankaccount_specific_use_',['Fund'])	

	manage_dependent_fields('studentacademicinformation_current_term_','studentacademicinformation_min_value_grade_',['1','2','3','4','5','6','7','8','9','10'])
	manage_dependent_fields('studentacademicinformation_current_term_','studentacademicinformation_max_value_grade_',['1','2','3','4','5','6','7','8','9','10'])
	manage_dependent_fields('universityinfo__','universityinfo_number_subjects_taken_',['1','2','3','4','5','6','7','8','9','10'])
	manage_dependent_fields('universityinfo__','universityinfo_number_subjects_failed_',['1','2','3','4','5','6','7','8','9','10'])
	manage_dependent_fields('universityinfo__','universityinfo_problems_with_subjects_check_',['1','2','3','4','5','6','7','8','9','10'])
	manage_dependent_fields('universityinfo__','universityinfo_problems_with_subjects_text_',['1','2','3','4','5','6','7','8','9','10'])
	manage_dependent_fields('universityinfo__','universityinfo_reprimands_for_low_assistance_',['1','2','3','4','5','6','7','8','9','10'])
	manage_dependent_fields('disbursementrequest_disbursement_case_','disbursementrequest_tuition_due_date_type_',['college_tuition_payment'])
	manage_dependent_fields('disbursementrequest_disbursement_case_','disbursementrequest_tuition_value_',['college_tuition_payment'])
	manage_dependent_fields('disbursementrequest_disbursement_case_','disbursementrequest_due_date_',['college_tuition_payment'])
	manage_dependent_fields('disbursementrequest_disbursement_case_','disbursementrequest_disbursement_value_',['college_tuition_payment'])
	manage_dependent_fields('disbursementrequest_value_payed_by_student_check_','disbursementrequest_payment_target_',['true'])
	manage_dependent_fields('disbursementrequest_value_payed_by_student_check_','disbursementrequest_student_payment_date_',['true'])
	manage_dependent_fields('disbursementrequest_value_payed_by_student_check_','disbursementrequest_value_payed_by_student_',['true'])

	manage_dependent_fields('disbursementrequest_value_payed_by_student_check_','disbursementrequest_student_payment_to_lumni_support_',['true'])

	manage_dependent_fields('disbursementrequest_disbursement_case_','disbursementrequest_student_payment_income_source_',['reimbursement_of_money'])
	manage_dependent_fields('disbursementrequest_disbursement_case_','disbursementrequest_payment_date_to_institution_',['reimbursement_of_money'])
	manage_dependent_fields('disbursementrequest_disbursement_case_','disbursementrequest_reimbursement_value_',['reimbursement_of_money'])
	manage_dependent_fields('disbursementrequest_disbursement_case_','disbursementrequest_student_payment_to_institution_support_',['reimbursement_of_money'])

	manage_dependent_fields('collection_stage_','collection_agreed_value_',['collection'])
	manage_dependent_fields('collection_stage_','collection_no_payment_reason_',['collection'])

	manage_dependent_fields('collection_stage_','collection_affiliation_status_',['production'])
	manage_dependent_fields('collection_stage_','collection_system_',['production'])
	manage_dependent_fields('collection_stage_','collection_affiliation_type_',['production'])

	manage_dependent_fields('studentfinancialinformation_billing_to_someone_else_','studentfinancialinformation_billing_owner_rfc_',['true'])
	manage_dependent_fields('studentfinancialinformation_billing_to_someone_else_','studentfinancialinformation_billing_owner_first_name_',['true'])
	manage_dependent_fields('studentfinancialinformation_billing_to_someone_else_','studentfinancialinformation_billing_owner_middle_name_',['true'])
	manage_dependent_fields('studentfinancialinformation_billing_to_someone_else_','studentfinancialinformation_billing_owner_last_name_',['true'])
	manage_dependent_fields('studentfinancialinformation_billing_to_someone_else_','studentfinancialinformation_billing_owner_bussiness_name_',['true'])
	manage_dependent_fields('studentfinancialinformation_billing_to_someone_else_','studentfinancialinformation_billing_owner_email_',['true'])
	manage_dependent_fields('studentfinancialinformation_billing_to_someone_else_','studentfinancialinformation_billing_owner_address_',['true'])


}