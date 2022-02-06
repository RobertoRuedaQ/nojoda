$(document).on('turbolinks:load',function () {


	$('.team-supervisor-dropdown').on('select2:selecting select2:unselecting',function(){
		$('#hidden_teams_previous_').val($(this).val())
	})

	$('.team-supervisor-dropdown').on('change',function(){
		params = ''
		previous = cleanTeamArrays($('#hidden_teams_previous_').val().split(','))
		supervisors = cleanTeamArrays($(this).val())

		result = deduceTheChange(previous,supervisors)
		if(result.change.length > 0){
			params = 'teams=' + location.pathname.split('/')[2] 

			if(result.action == 'add'){
				target_path = '/team_supervisors/create_supervisor'
			}else if(result.action == 'remove'){
				target_path = '/team_supervisors/destroy_supervisor'
			}

			for(i = 0; i < result.change.length; i++){
				params += '&member[]=' +result.change[i]
			}

			lumniPost(target_path,params)
		}
	})
})





function cleanTeamArrays(target_array){
	tempArray = []
	target_array.map(function(item,index){
		if(item != ""){
			tempArray.push(item)
		}
	})
	return tempArray
}

function getArrayDifference(big, small){
	tempDifference = []
	big.map(function(item,index){
		if(small.find(function(element){ return element == item}) == undefined){
			tempDifference.push(item)
		}
	})
	return tempDifference
}

function deduceTheChange(previousArray,newArray){
	tempChange = []
	tempResult = 'no change'
	if(previousArray.length < newArray.length){
		tempChange = getArrayDifference(newArray,previousArray)
		tempResult = 'add'
	}else if(previousArray.length > newArray.length){
		tempChange = getArrayDifference(previousArray,newArray)
		tempResult = 'remove'
	}

	result = {	action: tempResult,
				change: tempChange}
	return result
}
