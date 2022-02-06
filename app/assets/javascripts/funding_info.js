$(document).on('turbolinks:load',function () {
	if(typeof $('application')[0] != 'undefined'){
		$('[id^='+'studentacademicinformation_funding_need_]').not('.switcher-input').each(function(){
			funding_options_container_behavior(this)
		})

		$('[id^=studentacademicinformation_funding_need_]').not('.switcher-input').on('change',function(){
			funding_options_container_behavior(this)
		})
		$('[id^=studentacademicinformation_disbursements_periodicity_]').on('change',function(){
			set_disbursements_application_behavior(this)
		})
		$('[id^=studentacademicinformation_number_of_disbursements_requiered_]').on('change',function(){
			set_disbursements_application_behavior(this)
		})
		$('[id^=studentacademicinformation_disbursement_value_]').on('change',function(){
			set_disbursements_application_behavior(this)
		})
		$('[id^=studentacademicinformation_first_disbursement_date_]').on('change',function(){
			set_disbursements_application_behavior(this)
		})

		$('[id^=studentacademicinformation_first_disbursement_date_]').each(function(){
			$(this).trigger('change')
		})
		
	}


})


function funding_options_container_behavior(target_element){
	target_id = target_element.id.split('_').pop()
	if($(target_element).val() == 'true'){
		$('#funding_info_container_' + target_id).show()
	}else{
		$('#funding_info_container_' + target_id).hide()
		$('#disbursement_detail_container' + target_id).html('')
	}
}

function set_disbursements_application_behavior(target_element){
	target_id = target_element.id.split('_').pop()
	periodicity = $('#studentacademicinformation_disbursements_periodicity_' + target_id).val()
	disbursement_number = $('#studentacademicinformation_number_of_disbursements_requiered_' + target_id).val()
	disbursement_value = $('#studentacademicinformation_disbursement_value_' + target_id).val()
	disbursement_date = $('#studentacademicinformation_first_disbursement_date_' + target_id).val()
	living_expenses_check = $('#studentacademicinformation_living_expenses_check_' + target_id).val()

	if(![periodicity,disbursement_number,disbursement_value,disbursement_date].includes('')){
		params = 'application=' + $('application')[0].id
		params += '&periodicity=' + periodicity
		params += '&disbursement_number=' + disbursement_number
		params += '&disbursement_value=' + disbursement_value
		params += '&disbursement_date=' + disbursement_date
		params += '&target_id=' + target_id
		params += '&living_expenses_check=' + living_expenses_check
		lumniPost('/applications/set_disbursements',params)
	}

}