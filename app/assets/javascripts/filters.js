$(document).on('turbolinks:load',function () {
	$('#lumni_filter_funds_').on('change',function(){
		target_values = $(this).val()
		if(target_values.length > 0){
			params_array = []
			for(i=0;i < target_values.length; i++){
				params_array = params_array.concat(['funds[]=' + target_values[i]]) 
			}
		}

		lumniPost('/students/set_funding_opportunity_filter',params_array.join('&'))
	})

	function removeParamFromUrl(parameter){
		var url=document.location.href;
		var urlparts= url.split('?');

		if (urlparts.length>=2){
			var urlBase=urlparts.shift(); 
			var queryString=urlparts.join("?"); 

			var prefix = encodeURIComponent(parameter)+'=';
			var pars = queryString.split(/[&;]/g);
			for (var i= pars.length; i-->0;)               
					if (pars[i].lastIndexOf(prefix, 0)!==-1)   
							pars.splice(i, 1);
			url = urlBase+'?'+pars.join('&');
		}
		
		return url;
	}

	$('.per_page_select').on('change', function(event){
		let selected = event.target.value;
		let current_url = removeParamFromUrl('per_page');
		var urlparts = current_url.split('?');
		if(urlparts.length > 1){
			document.location.href = current_url + '&per_page=' + selected;
		}else{
			document.location.href = current_url + '?per_page=' + selected;
		}
	});

	

	$('.application-case-eq').on('change', function(event){
		let selected = event.target.value;
		if(selected == 'disbursement_request') {
			$('.dependent-of-disbursement-request').find('select').attr('disabled', false);
			$('.dependent-of-disbursement-request').find('select').siblings('button').attr('disabled', false);
			$('.dependent-of-disbursement-request').find('select').siblings('button').removeClass('disabled');
		}else{
			$('.dependent-of-disbursement-request').find('select').attr('disabled', true);
			$('.dependent-of-disbursement-request').find('select').siblings('button').attr('disabled', true);
			$('.dependent-of-disbursement-request').find('select').val('default').selectpicker('refresh');
		}
	});

	let request_type = $('.application-case-eq option:selected').val();
	if(request_type != 'disbursement_request'){
		$('.dependent-of-disbursement-request').find('select').attr('disabled', true);
		$('.dependent-of-disbursement-request').find('select').siblings('button').attr('disabled', true);
		$('.dependent-of-disbursement-request').find('select').val('default').selectpicker('refresh');
	}
})