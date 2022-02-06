$(document).on('turbolinks:load',function () {
	
	setDeleteAlert()
	set_lumni_accordion()
	setGeneralWarningAlert()


  $('[data-toggle="popover"]').popover();


	$('.buttonSubmit').on('click',function(){
		if($('#' + $(this).attr('target'))[0].checkValidity()){
			$(this).attr('disabled',true)
			$(this).html($(this).attr('data-disable-with'))
			$('#' + $(this).attr('target')).submit()
		}

	})



	 if ($('.numericField').length > 0){
	 	validate_numeric_fields()
	 }

	 $('#template_grid_').on('change',function(){
	 	params = 'grid=' + $(this).find("option:selected").val()
	 	uniform_grid(params)
	 })

	 $('.modal').on('show.bs.modal',function(){
	 	restore_button_text()
	 })


})



function clear_form(model_name,exceptions){
	exceptions = eval_string_inputs(exceptions)

	exceptions_text = ''
	for(i=0;i<exceptions.length;i++){
		exceptions_text += '[name="' + model_name + '[' + exceptions[i] + ']"]'
	}

	$('[name^='+ model_name +']').not(exceptions_text).each(function(){$(this).val('').trigger('change')})

	$('[data-direct-upload-url]').each(function(){
		$(this).removeAttr('disabled')
	})

	restore_lumni_js()
}


function restore_button_text(){
	$('button[data-disable-with][type=submit][original_text]').each(function(){
		if($(this).attr('data-disable-with') == $(this).html()){
			original_text = $(this).attr('original_text')
			$(this).html(original_text)
		}
	})
}


function eval_string_inputs(input){
	if(typeof input == "string"){
		result = eval(input)
	}else{
		result = input
	}
	return result
}




function set_lumni_accordion(){
	$("[id^='auto-collapse']").on('show.bs.collapse',function(){
		open_target = 'open-icon-' + $(this).attr('data-parent').split('#').pop() + '-' + this.id.split('-').pop()
		close_target = 'close-icon-' + $(this).attr('data-parent').split('#').pop() + '-' + this.id.split('-').pop()
		$('#' + open_target).attr('hidden',true)
		$('#' + close_target).attr('hidden',false)
	})
	$("[id^='auto-collapse']").on('hide.bs.collapse',function(){
		open_target = 'open-icon-' + $(this).attr('data-parent').split('#').pop() + '-' + this.id.split('-').pop() 
		close_target = 'close-icon-' + $(this).attr('data-parent').split('#').pop() + '-' + this.id.split('-').pop()
		$('#' + open_target).attr('hidden',false)
		$('#' + close_target).attr('hidden',true)
	})
}


function uniform_grid(params){
	lumniPost('/form_templates/' + location.pathname.split('/')[2] + '/uniform_grid',params)
}

	function validate_numeric_fields(){
	 	for(i=0;i<$('.numericField').length;i++){
	 		tempNumericId = '#' + $('.numericField')[i].id;
	 		prefix = ''
	 		postfix = ''

	 		if(typeof $(tempNumericId).attr('prefix') != 'undefined'){
	 			prefix = $(tempNumericId).attr('prefix')
	 		}
	 		if(typeof $(tempNumericId).attr('postfix') != 'undefined'){
	 			postfix = $(tempNumericId).attr('postfix')
	 		}
	 		if ($(tempNumericId.split('numericField')[0]).val() == ''){
	 			tempNumericValue = ''
	 		}else{
	 			tempNumericValue = prefix +
				new Intl.NumberFormat('us').format($(tempNumericId.split('numericField')[0]).val()) +
				postfix
	 		}
	 		$(tempNumericId).val(tempNumericValue)
	 	}

	}



	function passtheball(fromId, toId){
		$('#' + fromId)[0].style.display = "none"
		$('#' + toId)[0].style.display = "block"
		$('#' + toId).focus()
	}

	function passtheballback(fromId,toId,initialSym,finalSym){
		prefix = ""
		postfix = ""
		$('#' + fromId)[0].style.display = "none"
		$('#' + toId)[0].style.display = "block"

 		if(typeof $('#' + toId).attr('prefix') != 'undefined'){
 			prefix = $('#' + toId).attr('prefix')
 		}
 		if(typeof $('#' + toId).attr('postfix') != 'undefined'){
 			postfix = $('#' + toId).attr('postfix')
 		}


		
		if($('#' + fromId).val() == ''){
			newVal = ''
		}else{
			newVal = prefix + 
			new Intl.NumberFormat().format($('#' + fromId).val()) +
			postfix
		}
		
		$('#' + toId).val(newVal)
	}






function setErrroMessage(element,value_text,field_type){
  var errorTypes = ['badInput','customError','patternMismatch','rangeOverflow','rangeUnderflow','stepMismatch',
                'tooLong','tooShort','typeMismatch','valid','valueMissing']
	var target_error = ''

	targetText = JSON.parse(value_text)

	for (i = 0; i < errorTypes.length; i++) { 

		if($(element).val() > $(element).attr('max')){
			target_error = targetText['rangeOverflow']
			target_error += new Intl.NumberFormat().format($(element).attr('max'))
			break;
		}


		if(element.validity[errorTypes[i]] == true){
			target_error = targetText[errorTypes[i]];
			if(errorTypes[i] == 'rangeOverflow'){
				target_error += new Intl.NumberFormat().format($(element).attr('max'))
			}else if(errorTypes[i] == 'rangeUnderflow'){
				target_error += new Intl.NumberFormat().format($(element).attr('min'))
			}

			break;
		} 
	}

	event.preventDefault();
	cleanErrorMessage(element,field_type);
	errorText = document.createElement('small');
	errorText.classList.add('invalid-feedback');
	errorText.classList.add('force-display')
	errorText.innerHTML = target_error;
	if(['list','reference','countries','regions','cities','districts','institution','majors'].includes(field_type)){
		tempElement = element.parentElement.parentElement
		element.parentElement.classList.add('is-invalid')
		tempElement.appendChild(errorText)
	}else{
		element.parentElement.appendChild(errorText)
		element.classList.add('is-invalid')
		if ($('#' + element.id + 'numericField').length > 0){
			$('#' + element.id + 'numericField')[0].classList.add('is-invalid')
		}
	}



	if( document.querySelector('.is-invalid').id == ''){
		target_id = document.querySelector('.is-invalid').children[0].id
	}else{
		target_id = document.querySelector('.is-invalid').id
	}
    $('html,body').stop(true, false).animate({
        scrollTop: $('#' + target_id).offset().top - 350
    }, 1000);





}


function removeErrorMessage(element,field_type){
	try{
		if (element.validity.valid){
			cleanErrorMessage(element,field_type);
		}
	}catch(err){
	}
}

function cleanErrorMessage(element,field_type){
	if(['list','reference','countries','regions','cities','districts','institution','majors'].includes(field_type)){
		element.parentElement.classList.remove('is-invalid');
		previous = element.parentElement.parentElement.getElementsByClassName('invalid-feedback');

	}else if (['integer','float','decimal','percentage','number','currency'].includes(field_type)){
		element.classList.remove('is-invalid');
		if($('#'+element.id + 'numericField').length > 0){
			$('#'+element.id + 'numericField')[0].classList.remove('is-invalid')
		}

		previous = element.parentElement.getElementsByClassName('invalid-feedback');

	}else{
		element.classList.remove('is-invalid');
		previous = element.parentElement.getElementsByClassName('invalid-feedback');

	}
	if(typeof previous[0] != 'undefined'){
		previous[0].parentNode.removeChild(previous[0]);
	}
}



function setDeleteAlert(){

	$('.destroy').on('click',function(){
		var targetDestroy = $(this)

		swal({
		  title: targetDestroy.data('title'),
		  text: targetDestroy.data('text'),
		  type: "warning",
		  showCancelButton: true,
		  confirmButtonClass: "btn-danger",
		  confirmButtonText: targetDestroy.data('confirbuttontext'),
		  cancelButtonText: targetDestroy.data('cancelbuttontext'),
		  closeOnConfirm: false,
		  closeOnCancel: true
		},
		function(isConfirm) {
		  if (isConfirm) {
		  	$.ajax({
			  type: "DELETE",
			  url: targetDestroy.data('url') + '.js'
			});

		    swal(targetDestroy.data('destroyed'), targetDestroy.data('destroyedconfirmation'), "success");
		  } 
		});


	})		
}



function setGeneralWarningAlert(){
	$('.lumni-danger-alert').on('click',function(){
		console.log('funcionando alerta')
		var targetDestroy = $(this)

		swal({
		  title: targetDestroy.data('title'),
		  text: targetDestroy.data('text'),
		  type: "warning",
		  showCancelButton: true,
		  confirmButtonClass: "btn-danger",
		  confirmButtonText: targetDestroy.data('confirbuttontext'),
		  cancelButtonText: targetDestroy.data('cancelbuttontext'),
		  closeOnConfirm: false,
		  closeOnCancel: true
		},
		function(isConfirm) {
		  if (isConfirm) {
		  	lumniPost(targetDestroy.data('path'),targetDestroy.data('params'))
		    swal(targetDestroy.data('destroyed'), targetDestroy.data('destroyedconfirmation'), "success");
		    if(typeof targetDestroy.data('finaljs') != 'undefined'){
		    	eval(targetDestroy.data('finaljs'))
		    }

		  } 
		});


	})			
}


function cleanTargetContainer(containerId){
	$(containerId).html('')
}

