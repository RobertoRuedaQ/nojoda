$(document).on('turbolinks:load',function () {
	set_location_js()
	set_initial_region()
})


function set_initial_region(){
	$("[lumni_type='regions']").each(function(){
		region_id = this.id

		if($('[dependent*=' + region_id + '][lumni_type=countries]').length > 0){

			country_id = $('[dependent*=' + region_id + '][lumni_type=countries]')[0].id

			form_key = $(this).attr('form_key')
			city_id = $(this).attr('dependent')
			set_region_js(region_id,form_key,city_id,country_id)
		}
	})
}


function set_region_js(region_id,form_key,city_id,country_id){
	$('[id=' + region_id + '][form_key="' + form_key + '"]').on('change',function(){
		if($(this).find("option:selected").val() != ''){
			params = 'region=' + $(this).find("option:selected").val()
			params += '&country='+ $('#' + country_id).find("option:selected").val()
			$('#general_container-' + city_id).each(function(){
				params += '&model=' + $(this).attr('model')
				params += '&field=' + $(this).attr('field')
				params += '&options=' + $(this).attr('options')
				params += '&config=' + $(this).attr('config')
				params += '&region_class=' + region_id
				params += '&city_class=' + city_id
				params += '&country_class=' + country_id
				params += '&form_key=' + form_key
			})
			lumniPost('/locations/cities', params)
		}
	})
}

function set_location_js(){
	$('[class*= "lumni_countries"]').each(function(){
		current_country = $(this).find("option:selected").val()
		if(current_country == ''){
			hide_dependent_fields($(this))
		}
	})
	$('select[class*= "lumni_countries"]').on('change',function(){
		console.log($(this).is(':visible'))

		if($(this).is(':visible')){

			hide_dependent_fields($(this))
			dependent_fields = $(this).attr('dependent').split(';')
			if(typeof dependent_fields[0] != 'undefined'){
				target_region = dependent_fields[0]
			}
			if(typeof dependent_fields[1] != 'undefined'){
				target_city = dependent_fields[1]
			}

			current_country = $(this).find("option:selected").val()

			params = 'country=' + $(this).find("option:selected").val()
			$('#general_container-' + target_region).each(function(){
				params += '&model=' + $(this).attr('model')
				params += '&field=' + $(this).attr('field')
				params += '&options=' + $(this).attr('options')
				params += '&config=' + $(this).attr('config')
				params += '&region_class=' + target_region
				params += '&city_class=' + target_city
				params += '&country_class=' + $(this).id
				params += '&form_key=' + $(this).attr('form_key')
			})
			// console.log(params)
			lumniPost('/locations/regions', params)
		}


	})
}


function hide_dependent_fields(target_element){
	if(location.href.split('/')[3] != 'form_templates'){
		try{
			dependent_fields = target_element.attr('dependent').split(';')
			form_key = target_element.attr('form_key')
			dependent_fields.forEach(function(item,index){
				$('[id=form_group-' + item +'][form_key='+ form_key +']').hide()
			})
		}catch(error){
		}
	}
}