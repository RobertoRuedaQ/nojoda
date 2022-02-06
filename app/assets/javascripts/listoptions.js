$(document).on('turbolinks:load',function () {
	$('#list_type_dropdown_').on('change',function(){

		if( $(this).val() == 'functionality'){
			targetAction = 'form_functionality'

		}else{
			targetAction = 'form_values'
		}

		triggerFormListPost(targetAction)

	})

	$('#list_type_functionality_').on('change',function(){
		createFormListFunctionalityTable($(this).val())
	})


	$('#formFieldValueLabelModal').on('hidden.bs.modal',function(){
		$('#manageFormValueLabelModal').html('')
		$('#loaderFormValue').attr('hidden',false)
	})

	setFormListValuesLinks()


})


function triggerFormListPost(option){
	form_list = $('[id^="edit_form_list_"]')[0].id.split('_').pop()
	$.post("/form_lists/" + option + '?form_list=' + form_list)
	  .done(function() {
	  })
	  .fail(function() {
	  	location.reload();
	  })
	  .always(function() {
	  });

}

function createFormListFunctionalityTable(option){
	form_list = $('[id^="edit_form_list_"]')[0].id.split('_').pop()

	params = 'functionality=' + option + '&form_list=' + form_list

	$.post("/form_lists/translate_functionality",params)
	  .done(function() {
	  })
	  .fail(function() {
	  	location.reload();
	  })
	  .always(function() {
	  });

}


function updateFormValueLabel(labelId){
	$.post("/form_labels/"+labelId+"/update_label")
	  .done(function() {
	  })
	  .fail(function() {
	  	location.reload();
	  })
	  .always(function() {
	  });
}

function createFormValueLabel(language, form_list_value_id){
	params = '?language=' + language + '&form_list_value_id=' + form_list_value_id
	$.post("/form_labels/create_label" + params)
	  .done(function() {
	  })
	  .fail(function() {
	  	location.reload();
	  })
	  .always(function() {
	  });
}


function modifyFormListValue(value_id){
	$.post("/form_list_values/" + value_id + "/modify_form_list_value")
	  .done(function() {
	  })
	  .fail(function() {
	  	location.reload();
	  })
	  .always(function() {
	  });
}

function setFormListValuesLinks(){
	$('.updateFormValueLabel').on('click', function(){
		updateFormValueLabel($(this)[0].id.split('-').pop())
	})
	$('.createFormValueLabel').on('click', function(){
		targetId = $(this)[0].id.split('-')
		form_list_value_id = targetId.pop()
		language = targetId[targetId.length - 1]
		createFormValueLabel(language,form_list_value_id)
	})

	$('.modify-form-list-value').on('click',function(){
		value_id = $(this)[0].id.split('-').pop()
		modifyFormListValue(value_id)
	})

}