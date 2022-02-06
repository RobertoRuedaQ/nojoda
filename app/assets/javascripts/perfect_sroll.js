$(document).on('turbolinks:load',function () {
	$('.lumni-scroll').each(function(){
		new PerfectScrollbar(document.getElementById(this.id))
	})
})



