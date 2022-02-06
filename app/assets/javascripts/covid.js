$(document).on('turbolinks:load',function () {
	$('#conditional-additional-covid-info').hide()
	$("input[name^='covidemergency']").on('change',function(){
		console.log($("input[name^='covidemergency']:checked").val())
		if($("input[name^='covidemergency']:checked").val() == 'custom_adjustment'){
			$('#conditional-additional-covid-info').show()
		}else{
			$('#conditional-additional-covid-info').hide()
		}
	})
})



