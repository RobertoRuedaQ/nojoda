$(document).on('turbolinks:load',function () {
	if( location.hash != ""){
		activate_lumni_tab(location.hash)
	}

	$('.nav-link:not(.direct_link)').on('click',function(){
		location.hash = $(this).attr('href').split('#').pop()
	})

	$('.direct_link.nav-link').on('click',function(){
		$('.spinner').show()
		window.location.replace($(this).attr('href'))
	})


})


function activate_lumni_tab(target_tab){
	tabId = 'a[href="' + target_tab + '"]'
	if( $(tabId).length > 0 ){
		try {
			$(tabId).tab('show')
		}
		catch(error) {
		 
		}
	}
	if(typeof $(tabId).attr('parent-tab') != 'undefined'){
		new_id = '#' + $(tabId).attr('parent-tab')
		activate_lumni_tab(new_id)
	}
}




//window.location.replace(...)