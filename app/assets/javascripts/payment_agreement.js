$(document).on('turbolinks:load',function () {
	for(j=0;j<payment_agreement_fields().length;j++){
		set_payment_agreement_simulation(payment_agreement_fields()[j])
	}

	$('[id^=paymentagreement_agreement_case_]').on('change', function(){
		target_id = this.id.split('_').pop()
		target_value = $(this).val()

		if(target_value == 'normalization'){


		}else if(target_value == 'conciliation'){

		}else if(target_value == 'termination'){

		}
		console.log(target_value)

	})
})






function payment_agreement_fields(){
	original_fields = ["value", "rate", "number_payments","start_date"]
	fields = []
	for(i=0;i<original_fields.length;i++){
		fields = fields.concat(['paymentagreement_' + original_fields[i]])
	}
	return fields
}

function set_payment_agreement_simulation(field){
	$('[id^=' + field + ']').on('change',function(){
		target_id = this.id.split('_').pop()
		validation = true
		params = ''
		for(m = 0; m < payment_agreement_fields().length;m++){
			temp_id = '#' + payment_agreement_fields()[m] + '_' + target_id
			if( $(temp_id).val() == ''){
				validation = false
			}else{
				params += payment_agreement_fields()[m]+ '=' + $(temp_id).val() + '&'
			}
		}
		if(validation){
			lumniPost('/payment_agreements/simulate',params)
		}
	})
}


function simulate_payment_agreement(){

}