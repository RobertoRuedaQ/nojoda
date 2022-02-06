$(document).on('turbolinks:load',function () {
	if ($('#message-modal-user').length >0) {
		$('#message-modal-user').on('hidden.bs.modal',function(){
			$(this).attr('hidden',false)
			$('#message-modal-header').html("")
			$('#message-modal-body').html("")

		})

	}
})