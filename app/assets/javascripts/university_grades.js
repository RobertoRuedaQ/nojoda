function check_university_grades_compleation(application_id, section){
	if($('[university-grade=true]').length == 0 && $('[id^=university_grade_container]').length > 0){
		path = '/university_grades/approve_section'
		params = 'application_id=' + application_id
		params += '&section=' + section
		lumniPost(path,params)
	}
}