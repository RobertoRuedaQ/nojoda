$(document).on('turbolinks:load',function () {
	set_institutions_js()
})


function set_institutions_js(){
	$('[class*= "lumni_institutions"]').each(function(){
		current_institution = $(this).find("option:selected").val()
		if(current_institution == ''){
			hide_dependent_fields($(this))
		}
	})
	$('[class*= "lumni_institutions"]').on('change',function(){
		hide_dependent_fields($(this))
		dependent_fields = $(this).attr('dependent').split(';')
		if(typeof dependent_fields[0] != 'undefined'){
			target_major = dependent_fields[0]
		}

		current_institution = $(this).find("option:selected").val()

		params = 'institution=' + $(this).find("option:selected").val()
		$('#general_container-' + target_major).each(function(){
			params += '&model=' + $(this).attr('model')
			params += '&field=' + $(this).attr('field')
			params += '&options=' + $(this).attr('options')
			params += '&config=' + $(this).attr('config')
			params += '&major_class=' + target_major
			params += '&form_key=' + $(this).attr('form_key')
			params += '&list_number=' + $(this).attr('list_number')

			// console.log(params)
			lumniPost('/institutions/set_major', params)

		})
	})
}

