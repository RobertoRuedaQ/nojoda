class StudentConfigsController < ApplicationController
	def index
		@student_config = StudentConfig.lumniStart(params,current_company, list: current_user.template('StudentConfig','student_configs',current_user))
		contactStudentConfig = @student_config.lumniSave(params,current_user, list: current_user.template('StudentConfig','student_configs',current_user))
		lumniClose(@student_config,contactStudentConfig)
	end

	def new
		@student_config = StudentConfig.lumniStart(params,current_company, list: current_user.template('StudentConfig','student_configs',current_user))
		contactStudentConfig = @student_config.lumniSave(params,current_user, list: current_user.template('StudentConfig','student_configs',current_user))
		lumniClose(@student_config,contactStudentConfig)
	end

	def create
		@student_config = StudentConfig.lumniStart(params,current_company, list: current_user.template('StudentConfig','student_configs',current_user))
		contactStudentConfig = @student_config.lumniSave(params,current_user, list: current_user.template('StudentConfig','student_configs',current_user))
		lumniClose(@student_config,contactStudentConfig)
	end

	def edit
		@student_config = StudentConfig.lumniStart(params,current_company, list: current_user.template('StudentConfig','student_configs',current_user))
		contactStudentConfig = @student_config.lumniSave(params,current_user, list: current_user.template('StudentConfig','student_configs',current_user))
		lumniClose(@student_config,contactStudentConfig)
	end

	def update
		@student_config = StudentConfig.lumniStart(params,current_company, list: current_user.template('StudentConfig','student_configs',current_user))
		contactStudentConfig = @student_config.lumniSave(params,current_user, list: current_user.template('StudentConfig','student_configs',current_user))
		lumniClose(@student_config,contactStudentConfig)
	end
	def destroy
		@student_config = StudentConfig.lumniStart(params,current_company, list: current_user.template('StudentConfig','student_configs',current_user))
		contactStudentConfig = @student_config.lumniSave(params,current_user, list: current_user.template('StudentConfig','student_configs',current_user))
		lumniClose(@cluster,contactStudentConfig)
	end
end