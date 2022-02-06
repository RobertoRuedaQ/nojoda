$(document).on('turbolinks:load',function () {
	setGlobalSwitches()
})


function setGlobalSwitches(){

	$(".switcher-input").on('change', function() {
     togBtn= $(this);
     hiddenOne = $('#' + $(this).attr('id').split('frontcheck')[0])
     hiddenOne.val(togBtn.prop('checked')).trigger('change');
	})

}