$(document).on('turbolinks:load',function () {


	$('.team-funding_opportunity-dropdown').on('select2:selecting select2:unselecting',function(){
		$('#hidden_teams_previous_').val($(this).val())
	})

	$('.team-funding_opportunity-dropdown').on('change',function(){
		params = ''
		previous = cleanTeamArrays($('#hidden_teams_previous_').val().split(','))
		supervisors = cleanTeamArrays($(this).val())

		result = deduceTheChange(previous,supervisors)
		if(result.change.length > 0){
			params = 'teams=' + location.pathname.split('/')[2] 
			if(result.action == 'add'){
				target_path = '/funding_opportunity_teams/create_supervisor'
			}else if(result.action == 'remove'){
				target_path = '/funding_opportunity_teams/destroy_supervisor'
			}

			for(i = 0; i < result.change.length; i++){
				params += '&member[]=' +result.change[i]
			}

			lumniPost(target_path,params)
		}
	})
})
