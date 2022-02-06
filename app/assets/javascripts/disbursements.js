$(document).on('turbolinks:load',function () {
	set_living_expenses_check_behavior()

	$('[id^=disbursementpayment_payment_case_]').on('change',disbursement_payment_type_to_account(this))
})

function set_living_expenses_check_behavior(){
	$('[id^=disbursementrequest_living_expenses_check_]').not('.switcher-input').each(function(){
		living_expenses_check_behavior(this)
	})
	$('[id^=disbursementrequest_living_expenses_check_]').not('.switcher-input').on('change',function(){
		living_expenses_check_behavior(this)
	})
}

function living_expenses_check_behavior(element){
	target_id = element.id.split('_').pop()
	validation = $(element).val()
	if(validation == 'true'){
		$('#associated_living_expenses_' + target_id).show()
	}else{
		$('#associated_living_expenses_' + target_id).hide()
	}

}

function disbursement_payment_type_to_account(element){
	console.log(this.id)
}