$(document).on('turbolinks:load',function () {


	$('.bizdev-team-dropdown').on('select2:selecting select2:unselecting',function(){
		$('#hidden_teams_previous_').val($(this).val())
	})

	$('.bizdev-team-dropdown').on('change',function(){
		params = ''
		previous = cleanTeamArrays($('#hidden_teams_previous_').val().split(','))
		supervisors = cleanTeamArrays($(this).val())

		result = deduceTheChange(previous,supervisors)
		if(result.change.length > 0){
			params = 'teams=' + $('#project_div').attr('target')

			if(result.action == 'add'){
				target_path = '/bizdev_businesses/create_team'
			}else if(result.action == 'remove'){
				target_path = '/bizdev_businesses/destroy_team'
			}

			for(i = 0; i < result.change.length; i++){
				params += '&member[]=' +result.change[i]
			}

			lumniPost(target_path,params)
		}
	})
})



