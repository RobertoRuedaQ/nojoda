class ProjectTaskTranslatesController < ApplicationController
	def index
		@project_task_translate = ProjectTaskTranslate.lumniStart(params,current_company, list: current_user.template('ProjectTaskTranslate','project_task_translates',current_user))
		contactProjectTaskTranslate = @project_task_translate.lumniSave(params,current_user, list: current_user.template('ProjectTaskTranslate','project_task_translates',current_user))
		lumniClose(@project_task_translate,contactProjectTaskTranslate)
	end

	def new
		@project_task_translate = ProjectTaskTranslate.lumniStart(params,current_company, list: current_user.template('ProjectTaskTranslate','project_task_translates',current_user))
		contactProjectTaskTranslate = @project_task_translate.lumniSave(params,current_user, list: current_user.template('ProjectTaskTranslate','project_task_translates',current_user))
		lumniClose(@project_task_translate,contactProjectTaskTranslate)
	end

	def create
		@project_task_translate = ProjectTaskTranslate.lumniStart(params,current_company, list: current_user.template('ProjectTaskTranslate','project_task_translates',current_user))
		contactProjectTaskTranslate = @project_task_translate.lumniSave(params,current_user, list: current_user.template('ProjectTaskTranslate','project_task_translates',current_user))
		lumniClose(@project_task_translate,contactProjectTaskTranslate)
	end

	def edit
		@project_task_translate = ProjectTaskTranslate.lumniStart(params,current_company, list: current_user.template('ProjectTaskTranslate','project_task_translates',current_user))
		contactProjectTaskTranslate = @project_task_translate.lumniSave(params,current_user, list: current_user.template('ProjectTaskTranslate','project_task_translates',current_user))
		lumniClose(@project_task_translate,contactProjectTaskTranslate)
	end

	def update
		@project_task_translate = ProjectTaskTranslate.lumniStart(params,current_company, list: current_user.template('ProjectTaskTranslate','project_task_translates',current_user))
		contactProjectTaskTranslate = @project_task_translate.lumniSave(params,current_user, list: current_user.template('ProjectTaskTranslate','project_task_translates',current_user))
		lumniClose(@project_task_translate,contactProjectTaskTranslate)
	end
	def destroy
		@project_task_translate = ProjectTaskTranslate.lumniStart(params,current_company, list: current_user.template('ProjectTaskTranslate','project_task_translates',current_user))
		contactProjectTaskTranslate = @project_task_translate.lumniSave(params,current_user, list: current_user.template('ProjectTaskTranslate','project_task_translates',current_user))
		lumniClose(@cluster,contactProjectTaskTranslate)
	end
end