$(document).on('turbolinks:load',function () {
	$('[id^="student_routes_team_profile_id_"]').on('changed.bs.select', function (e, clickedIndex, isSelected, previousValue){
		target_id = this.id.split('_').pop()
		target_route = $(this).find("option:selected").val()
		if(target_route != ''){
			updateStudentPath(target_id,target_route)
		}
	})
})

function updateStudentPath(target_id,target_route){
	params = 'student_route=' + target_id + '&profile=' + target_route
	path = '/student_routes/profile'
	lumniPost(path,params)
}