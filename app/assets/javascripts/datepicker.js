


$(document).on('turbolinks:load',function () {
	activateDatepickers()
  });

function activateDatepickers(){
  $('.lumni_date').datepicker({
  	format: 'yyyy-mm-dd',
    autoclose: true,
    language: $('#js-lumni-language').attr('locale'),
    todayHighlight: true,
    disableTouchKeyboard: true
	}).on('changeDate',function(){
		removeErrorMessage(this,'date')
	}).on('change',function(){
		$(this).trigger('changeDate')
		$(this).datepicker('hide')
	})



  $('.lumni_datetime').datepicker({
  	format: 'yyyy-mm-dd',
    autoclose: true,
    language: $('#js-lumni-language').attr('locale'),
    todayHighlight: true,
    disableTouchKeyboard: true
	}).on('changeDate',function(){
		removeErrorMessage(this,'date')
	}).on('change',function(){
		$(this).trigger('changeDate')
		$(this).datepicker('hide')
	})




}
