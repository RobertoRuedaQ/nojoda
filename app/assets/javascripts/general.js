

function enable_submit(){
  $('[name=commit]').attr('disabled',false)
}

function lumniPost(path,params,done_execute_text = "",element = ""){
	$.post(path,params)
  .done(function() {
    eval(done_execute_text)
  })
  .fail(function() {
  	location.reload();
  })
  .always(function() {
  });

}

function lumniGet(path,params){
	$.get(path,params)
  .done(function() {
  })
  .fail(function() {
  	location.reload();
  })
  .always(function() {
  });

}

function show_full_page_lumni_spinner(){
  $('.spinner').show()
}

function restore_lumni_js(){
  activateDatepickers()
  validate_numeric_fields();
  $(".selectpicker").selectpicker( 'destroy', true ).addClass('selectpicker')
  $(".selectpicker").selectpicker();
  setAutosize();
  $('[data-toggle="popover"]').popover();
  $('.knob-progress input').knob();
  setGlobalSwitches()

  lumni_jodit()
  lumni_quill()

  cleanMultipleSelection();
  createMultipleSelection();
  multiplePickListDropdown()

  setAllDependentFields()
  setGeneralWarningAlert()

}

