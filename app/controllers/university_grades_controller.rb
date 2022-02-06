class UniversityGradesController < ApplicationController
	include LumniApplicationForms	
	def index
		@university_grade = UniversityGrade.lumniStart(params,current_company, list: current_user.template('UniversityGrade','university_grades',current_user))
		contactUniversityGrade = @university_grade.lumniSave(params,current_user, list: current_user.template('UniversityGrade','university_grades',current_user))
		lumniClose(@university_grade,contactUniversityGrade)
	end

	def new
		@university_grade = UniversityGrade.lumniStart(params,current_company, list: current_user.template('UniversityGrade','university_grades',current_user))
		contactUniversityGrade = @university_grade.lumniSave(params,current_user, list: current_user.template('UniversityGrade','university_grades',current_user))
		lumniClose(@university_grade,contactUniversityGrade)
	end

	def create
		@university_grade = UniversityGrade.lumniStart(params,current_company, list: current_user.template('UniversityGrade','university_grades',current_user))
		contactUniversityGrade = @university_grade.lumniSave(params,current_user, list: current_user.template('UniversityGrade','university_grades',current_user))
		lumniClose(@university_grade,contactUniversityGrade)
	end

	def edit
		@university_grade = UniversityGrade.lumniStart(params,current_company, list: current_user.template('UniversityGrade','university_grades',current_user))
		contactUniversityGrade = @university_grade.lumniSave(params,current_user, list: current_user.template('UniversityGrade','university_grades',current_user))
		lumniClose(@university_grade,contactUniversityGrade)
	end

	def update
		@university_grade = UniversityGrade.lumniStart(params,current_company, list: current_user.template('UniversityGrade','university_grades',current_user))
		contactUniversityGrade = @university_grade.lumniSave(params,current_user, list: current_user.template('UniversityGrade','university_grades',current_user))
		lumniClose(@university_grade,contactUniversityGrade)
	end
	def destroy
		@university_grade = UniversityGrade.lumniStart(params,current_company, list: current_user.template('UniversityGrade','university_grades',current_user))
		contactUniversityGrade = @university_grade.lumniSave(params,current_user, list: current_user.template('UniversityGrade','university_grades',current_user))
		lumniClose(@cluster,contactUniversityGrade)
	end


	def storing_university_grades
		@application_id = params[:temp][:application_id]
		@section_id = params[:temp][:section]

		@application = Application.full_application.cached_find(@application_id)
		initial_module = @application.current_module_number
		@full_student = User.full_student.cached_find(@application.user_id)
		@section = OriginationSection.cached_find(@section_id)

		@target_record = UniversityGrade.cached_find(params[:temp][:target_id])
		@target_record.update(params_application_user(@section.resource))

	end

	def approve_section
		@application_id = params[:application_id]
		@section_id = params[:section]

		@application = Application.full_application.cached_find(@application_id)
		initial_module = @application.current_module_number
		@full_student = User.full_student.cached_find(@application.user_id)
		@section = OriginationSection.cached_find(@section_id)

		ApplicationSectionTrack.create(application_id: @application.id,origination_section_id: @section.id)
		@application.update(step: @section.origination_module.origination.current_step(@application))
		@module_next = initial_module != @application.current_module_number
	end






private

	def params_application_user template
		permited_keys = template.template_hash(current_user,current_company).keys
		permited_required = eval(template.object).model_name.to_s.downcase.to_sym

		params[permited_required].keys.each do |temp_key|
			if params[permited_required][temp_key] == ''
				params[permited_required] = params[permited_required].except(temp_key)
			elsif params[permited_required][temp_key].is_a? Array
				params[permited_required][temp_key] = params[permited_required][temp_key].join(';')
			end
		end

		params.require(permited_required).permit(permited_keys)
	end

end