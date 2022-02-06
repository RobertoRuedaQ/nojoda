$(document).on('turbolinks:load',function () {
	set_isa_status_alert()
})



function set_isa_status_alert(){
	$('.lumni-isa-status-alert').on('click',function(){
		console.log('funcionando alerta')
		var target_action = $(this)

		swal({
		  title: target_action.data('title'),
		  text: target_action.data('text'),
		  type: "warning",
		  showCancelButton: true,
		  confirmButtonClass: "btn-warning",
		  confirmButtonText: target_action.data('confirbuttontext'),
		  cancelButtonText: target_action.data('cancelbuttontext'),
		  closeOnConfirm: false,
		  closeOnCancel: true,
		  showLoaderOnConfirm: true
		},
		function() {
		  	lumniPost(target_action.data('path'),target_action.data('params'),"swal(element.data('successheader'), element.data('successconfirmation'), 'success')",target_action)
		  	
		});


	})			
}