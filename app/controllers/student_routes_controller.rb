class StudentRoutesController < ApplicationController
	def index
		@student_route = StudentRoute.lumniStart(params,current_company, list: current_user.template('StudentRoute','student_routes',current_user))
		contactStudentRoute = @student_route.lumniSave(params,current_user, list: current_user.template('StudentRoute','student_routes',current_user))
		lumniClose(@student_route,contactStudentRoute)
	end

	def new
		@student_route = StudentRoute.lumniStart(params,current_company, list: current_user.template('StudentRoute','student_routes',current_user))
		contactStudentRoute = @student_route.lumniSave(params,current_user, list: current_user.template('StudentRoute','student_routes',current_user))
		lumniClose(@student_route,contactStudentRoute)
	end

	def create
		@student_route = StudentRoute.lumniStart(params,current_company, list: current_user.template('StudentRoute','student_routes',current_user))
		contactStudentRoute = @student_route.lumniSave(params,current_user, list: current_user.template('StudentRoute','student_routes',current_user))
		lumniClose(@student_route,contactStudentRoute)
	end

	def edit
		@student_route = StudentRoute.lumniStart(params,current_company, list: current_user.template('StudentRoute','student_routes',current_user))
		contactStudentRoute = @student_route.lumniSave(params,current_user, list: current_user.template('StudentRoute','student_routes',current_user))
		lumniClose(@student_route,contactStudentRoute)
	end

	def update
		@student_route = StudentRoute.lumniStart(params,current_company, list: current_user.template('StudentRoute','student_routes',current_user))
		contactStudentRoute = @student_route.lumniSave(params,current_user, list: current_user.template('StudentRoute','student_routes',current_user))
		lumniClose(@student_route,contactStudentRoute)
	end
	def destroy
		@student_route = StudentRoute.lumniStart(params,current_company, list: current_user.template('StudentRoute','student_routes',current_user))
		contactStudentRoute = @student_route.lumniSave(params,current_user, list: current_user.template('StudentRoute','student_routes',current_user))
		lumniClose(@cluster,contactStudentRoute)
	end

	def profile
		StudentRoute.cached_find(params[:student_route]).update(team_profile_id: params[:profile])
	end
end