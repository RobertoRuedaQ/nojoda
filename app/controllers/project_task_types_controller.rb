class ProjectTaskTypesController < ApplicationController
	def index
		@task_type = ProjectTaskType.lumniStart(params,current_company)
		taskTypeResult = @task_type.lumniSave(params,current_user)
		lumniClose(@task_type,taskTypeResult)
	end

	def new
		@task_type = ProjectTaskType.lumniStart(params,current_company)
		taskTypeResult = @task_type.lumniSave(params,current_user)
		lumniClose(@task_type,taskTypeResult)
	end

	def create
		@task_type = ProjectTaskType.lumniStart(params,current_company)
		taskTypeResult = @task_type.lumniSave(params,current_user)
		lumniClose(@task_type,taskTypeResult)
	end

	def edit
		@task_type = ProjectTaskType.lumniStart(params,current_company)
		taskTypeResult = @task_type.lumniSave(params,current_user)
		lumniClose(@task_type,taskTypeResult)
	end

	def update
		@task_type = ProjectTaskType.lumniStart(params,current_company)
		taskTypeResult = @task_type.lumniSave(params,current_user)
		lumniClose(@task_type,taskTypeResult)
	end
	def destroy
		@task_type = ProjectTaskType.lumniStart(params,current_company)
		taskTypeResult = @task_type.lumniSave(params,current_user)
		lumniClose(@task_type,taskTypeResult)
		@result =taskTypeResult
	end
end
