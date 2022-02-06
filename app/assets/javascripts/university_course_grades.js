$(document).on('turbolinks:load',function () {
	$('[id^=universitygrade_number_of_courses_taken_]').on('change',function(){
		set_university_course_grade_container(this)
	})
	set_university_course_grade_button_behavior()

})

function set_university_course_grade_container(element){
	params = 'application=' + $('application')[0].id
	params += '&student=' + $('student')[0].id
	params += '&section=' + $('section[model=UniversityGrade]')[0].id
	params += '&number=' + $(element).val()
	lumniPost('/university_course_grades/set_grades',params)
}

function set_university_course_grade_button_behavior(){
	if($('[course=incomplete]').length > 0){
		$('button[target^=edit_university_grade_]').attr('disabled',true)
	}else{
		$('button[target^=edit_university_grade_]').attr('disabled',false)
	}
}