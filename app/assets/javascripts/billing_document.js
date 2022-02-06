$(document).on('turbolinks:load',function () {

	align_payment_values()

	$('#custom_value_display_').on('change',function(){

		if($(this).val() == 'true'){
			$('#button-webchecout-payment').attr('disabled',true)
			$('#main-value-to-pay').hide()
			$('#custom-value-to-pay').show()
			restore_lumni_js()
		}else{
			$('#button-webchecout-payment').attr('disabled',false)
			$('#main-value-to-pay').show()
			$('#custom-value-to-pay').hide()
			$('#target_value_').val($('#original_value').val()).trigger('input')
		}
	})
	hide_or_show_payment_option_by_value($('#original_value').val());
	set_all_initial_transaction_value($('#original_value').val())
})

function align_payment_values(){
	$('#target_value_').on('input',function(){
		current_value = $(this).val()
		hide_or_show_payment_option_by_value(current_value);
		set_all_initial_transaction_value(current_value)
	})
	$('#target_value_').on('focusout',function(){
		current_value = $(this).val()
		hide_or_show_payment_option_by_value(current_value);
		manage_webcheckout_custom_value(current_value)
	})
}

function hide_or_show_payment_option_by_value(value){
	if($('#cash-method-button-wompi').length) {
		if(value < 140000){
			$('#cash-method-button-wompi').hide();
			$('#cash-method-button-mercadopago .btn').show();
		}else{
			$('#cash-method-button-mercadopago .btn').hide();
			$('#cash-method-button-wompi').show();
		}
	}
}

function set_all_initial_transaction_value(current_value){

	$('[name=paymentinfo\\[value\\]],[id^=paymentinfo_value_]').each(function() {
		$(this).val(current_value).trigger('change')
	})

	$('[name=amount],[name=taxReturnBase]').each(function() {
		$(this).val(current_value).trigger('change')
	})

	$('[name=signature]').val($('[name=backup_signature]').val()).trigger('change')

	restore_lumni_js()
}

function manage_webcheckout_custom_value(current_value){
	if($('[name=amount],[name=taxReturnBase],[name=referenceCode],[name=signature]').length == 4){
		$('.spinner').show()
		path = '/billing_documents/' + location.href.split('/').pop() + '/set_webcheckout'
		params = 'value=' + current_value
		params += '&transaction_id=' + $('[name=referenceCode]').val()
		lumniPost(path,params)
	}

}