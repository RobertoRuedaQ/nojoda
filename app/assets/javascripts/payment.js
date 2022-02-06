$(document).on('turbolinks:load',function () {
	$('[id^=target_value_]').focusout(function(){
		manage_payment_options_visibility(this)
	})
	$('[id^=target_value_]').focus(function(){
		manage_payment_options_visibility(this)
	})
})

function manage_payment_options_visibility(element){
	if(parseFloat($(element).attr('max')) < parseFloat($(element).val())){
		$(element).trigger('invalid')
		$('#accordion-payment').hide()
	}else{
		$(element).trigger('valid')
		$('#accordion-payment').show()
	}

}