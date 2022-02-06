$(document).on('turbolinks:load',function () {

	adjust_disbursement_by_max_percentage_allowed('studentacademicinformation')
	adjust_disbursement_by_max_percentage_allowed('disbursementrequest')

	$('[id^=applicant_summary_option_view_]').not('.switcher-input').on('change',function(){
		target_value = $(this).val()
		target_id = this.id.split('_').pop()
		path = '/funding_options/' + target_id + '/changes_visibility'
		params = 'value=' + target_value

		lumniPost(path,params)

	})	

	$('[legal-document-download]').on('click',function(){
		if($(this).parent().parent()[0].checkValidity()){
			window.open($(this).attr('legal-document-download'));
		}
	})

	$('[id^=application_automatic_show_financial_proposals_]').not('.switcher-input').on('change',function(){
		target_value = $(this).val()
		target_id = this.id.split('_').pop()
		path = '/applications/' + target_id + '/set_show_financial_proposals'
		params = 'show_financial_proposals=' + target_value
		lumniPost(path,params)
	})

})


function adjust_disbursement_by_max_percentage_allowed(target_object){
	$('[id^=' + target_object + '_tuition_value_]').on('change',function(){
		target_id = this.id.split('_').pop()
		max_funded_percentage = $('#' + target_object + '_tuition_funded_percentage_' + target_id).val() / 100
		tuition_value = $(this).val()
		max_funded_value = Math.floor(max_funded_percentage * tuition_value)

		// $('#' + target_object + '_disbursement_value_' + target_id).attr('max',max_funded_value)
		$('#' + target_object + '_disbursement_value_' + target_id).val(max_funded_value)
		$('#' + target_object + '_disbursement_value_' + target_id).trigger('input')
		validate_numeric_fields()
	})
}