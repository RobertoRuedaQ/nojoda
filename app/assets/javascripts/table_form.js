$(document).on('turbolinks:load',function () {
	$('button[id*=tableFormb-]').on('click',function(){
		console.log($('#' + $(this).attr('id').split('-')[1]))

	})
})