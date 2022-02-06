class UniversityCourseGradesController < ApplicationController
	include LumniApplicationForms
	def index
		@university_course_grade = UniversityCourseGrade.lumniStart(params,current_company, list: current_user.template('UniversityCourseGrade','university_course_grades',current_user))
		contactUniversityCourseGrade = @university_course_grade.lumniSave(params,current_user, list: current_user.template('UniversityCourseGrade','university_course_grades',current_user))
		lumniClose(@university_course_grade,contactUniversityCourseGrade)
	end

	def new
		@university_course_grade = UniversityCourseGrade.lumniStart(params,current_company, list: current_user.template('UniversityCourseGrade','university_course_grades',current_user))
		contactUniversityCourseGrade = @university_course_grade.lumniSave(params,current_user, list: current_user.template('UniversityCourseGrade','university_course_grades',current_user))
		lumniClose(@university_course_grade,contactUniversityCourseGrade)
	end

	def create
		@university_course_grade = UniversityCourseGrade.lumniStart(params,current_company, list: current_user.template('UniversityCourseGrade','university_course_grades',current_user))
		contactUniversityCourseGrade = @university_course_grade.lumniSave(params,current_user, list: current_user.template('UniversityCourseGrade','university_course_grades',current_user))
		lumniClose(@university_course_grade,contactUniversityCourseGrade)
	end

	def edit
		@university_course_grade = UniversityCourseGrade.lumniStart(params,current_company, list: current_user.template('UniversityCourseGrade','university_course_grades',current_user))
		@section = FormTemplate.find(params[:section_id])
		@target_template = @section.present? && @section.child_id.present? ? FormTemplate.find(@section.child_id).cached_template_hash(current_user,current_company) : current_user.template('UniversityCourseGrade','university_course_grades',current_user)
		contactUniversityCourseGrade = @university_course_grade.lumniSave(params,current_user, list: current_user.template('UniversityCourseGrade','university_course_grades',current_user))
		lumniClose(@university_course_grade,contactUniversityCourseGrade)
	end

	def update
		@section = FormTemplate.find(params[:temp][:section])
		@university_course_grade = UniversityCourseGrade.lumniStart(params,current_company, list: current_user.template('UniversityCourseGrade','university_course_grades',current_user))
		contactUniversityCourseGrade = @university_course_grade.lumniSave(params,current_user, list: current_user.template('UniversityCourseGrade','university_course_grades',current_user))
		lumniClose(@university_course_grade,contactUniversityCourseGrade)
	end
	def destroy
		@university_course_grade = UniversityCourseGrade.lumniStart(params,current_company, list: current_user.template('UniversityCourseGrade','university_course_grades',current_user))
		contactUniversityCourseGrade = @university_course_grade.lumniSave(params,current_user, list: current_user.template('UniversityCourseGrade','university_course_grades',current_user))
		lumniClose(@cluster,contactUniversityCourseGrade)
	end

	def set_grades
		section = OriginationSection.cached_find(params[:section])
		student = User.cached_find(params[:student])
		application = Application.cached_find(params[:application])
		@section = section.cached_form_template
		
		@university_course_grade = applicationFormUniversityCourseGrade section, student, application, number: params[:number].to_i
		@grade_id = @university_course_grade.count > 0 ? @university_course_grade.first.university_grade_id : nil

	end
end