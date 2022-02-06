class SchoolGradesController < ApplicationController
	def index
		@school_grade = SchoolGrade.lumniStart(params,current_company, list: current_user.template('SchoolGrade','school_grades',current_user))
		contactSchoolGrade = @school_grade.lumniSave(params,current_user, list: current_user.template('SchoolGrade','school_grades',current_user))
		lumniClose(@school_grade,contactSchoolGrade)
	end

	def new
		@school_grade = SchoolGrade.lumniStart(params,current_company, list: current_user.template('SchoolGrade','school_grades',current_user))
		contactSchoolGrade = @school_grade.lumniSave(params,current_user, list: current_user.template('SchoolGrade','school_grades',current_user))
		lumniClose(@school_grade,contactSchoolGrade)
	end

	def create
		@school_grade = SchoolGrade.lumniStart(params,current_company, list: current_user.template('SchoolGrade','school_grades',current_user))
		contactSchoolGrade = @school_grade.lumniSave(params,current_user, list: current_user.template('SchoolGrade','school_grades',current_user))
		lumniClose(@school_grade,contactSchoolGrade)
	end

	def edit
		@school_grade = SchoolGrade.lumniStart(params,current_company, list: current_user.template('SchoolGrade','school_grades',current_user))
		contactSchoolGrade = @school_grade.lumniSave(params,current_user, list: current_user.template('SchoolGrade','school_grades',current_user))
		lumniClose(@school_grade,contactSchoolGrade)
	end

	def update
		@school_grade = SchoolGrade.lumniStart(params,current_company, list: current_user.template('SchoolGrade','school_grades',current_user))
		contactSchoolGrade = @school_grade.lumniSave(params,current_user, list: current_user.template('SchoolGrade','school_grades',current_user))
		lumniClose(@school_grade,contactSchoolGrade)
	end
	def destroy
		@school_grade = SchoolGrade.lumniStart(params,current_company, list: current_user.template('SchoolGrade','school_grades',current_user))
		contactSchoolGrade = @school_grade.lumniSave(params,current_user, list: current_user.template('SchoolGrade','school_grades',current_user))
		lumniClose(@cluster,contactSchoolGrade)
	end
end