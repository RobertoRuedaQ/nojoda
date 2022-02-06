$(document).on('turbolinks:load',function () {

	$('.historyModalLink').on('click',function(){
		
		$("[id^='historyModalBody']").each(function(){
			$(this).html('')});
		$('.spinner').show();

	})
})