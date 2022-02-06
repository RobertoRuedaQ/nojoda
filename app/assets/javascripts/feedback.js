$(document).on('turbolinks:load',function () {
	$('#feedback-button').on('click',function(){
		$('#feedback_modal_container').html('')
		$('#feedback-loader').show()
	})
})