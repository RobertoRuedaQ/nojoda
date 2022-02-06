class ProjectTasksController < ApplicationController
	def index
		@task = ProjectTask.full_task.lumniStart(params,current_company,list: current_user.template('ProjectTask','project_tasks',current_user))
		taskResult = @task.lumniSave(params,current_user,list: current_user.template('ProjectTask','project_tasks',current_user))
		lumniClose(@task,taskResult)
	end

	def new
		@task = ProjectTask.full_task.lumniStart(params,current_company,list: current_user.template('ProjectTask','project_tasks',current_user))
		taskResult = @task.lumniSave(params,current_user,list: current_user.template('ProjectTask','project_tasks',current_user))
		lumniClose(@task,taskResult)
	end

	def create
		@task = ProjectTask.full_task.lumniStart(params,current_company,list: current_user.template('ProjectTask','project_tasks',current_user))
		taskResult = @task.lumniSave(params,current_user,list: current_user.template('ProjectTask','project_tasks',current_user))
		lumniClose(@task,taskResult)
	end

	def edit
		@task = ProjectTask.full_task.lumniStart(params,current_company,list: current_user.template('ProjectTask','project_tasks',current_user))
		taskResult = @task.lumniSave(params,current_user,list: current_user.template('ProjectTask','project_tasks',current_user))
		lumniClose(@task,taskResult)
	end

	def update
		@task = ProjectTask.full_task.lumniStart(params,current_company,list: current_user.template('ProjectTask','project_tasks',current_user))
		taskResult = @task.lumniSave(params,current_user,list: current_user.template('ProjectTask','project_tasks',current_user))
		lumniClose(@task,taskResult)
	end
	def destroy
		@task = ProjectTask.full_task.lumniStart(params,current_company,list: current_user.template('ProjectTask','project_tasks',current_user))
		taskResult = @task.lumniSave(params,current_user,list: current_user.template('ProjectTask','project_tasks',current_user))
		lumniClose(@task,taskResult)
		@result =taskResult
	end

	def new_task
		params[:action] = 'new'
		@task = ProjectTask.full_task.lumniStart(params,current_company,list: current_user.template('ProjectTask','project_tasks',current_user))
		@card = ProjectCard.cached_find(params[:project_task][:project_card_id])
		if @card.project_task.kept.count > 0
			@task.position = @card.project_task.kept.maximum(:position) + 1
		else
			@task.position = 1
		end
		@task.project_card_id = params[:project_task][:project_card_id]
		@task.responsable = current_user
		@task.created_by = current_user
		@task.project_task_type = ProjectTaskType.find_by_title('custom')
		taskResult = @task.lumniSave(params,current_user,list: current_user.template('ProjectTask','project_tasks',current_user))
		lumniClose(@task,taskResult)
	end


	def new_checklist
		@main_task = ProjectTask.full_task.cached_find(params[:id])
		params[:action] = 'new'
		@task = ProjectTask.full_task.lumniStart(params,current_company,list: current_user.template('ProjectTask','project_tasks',current_user))
		if @main_task.checklist.kept.count > 0
			@task.position = @main_task.checklist.kept.maximum(:position) + 1
		else
			@task.position = 1
		end
		@task.parent_id = params[:id]
		@task.project_card_id = @main_task.project_card_id
		@task.responsable = current_user
		@task.created_by = current_user
		@task.project_task_type = ProjectTaskType.find_by_title('custom')
		taskResult = @task.lumniSave(params,current_user,list: current_user.template('ProjectTask','project_tasks',current_user))
		lumniClose(@task,taskResult)
	end

	def edit_task
		params[:action] = 'edit'
		@task = ProjectTask.full_task.lumniStart(params,current_company,list: current_user.template('ProjectTask','project_tasks',current_user))
		@task.title = @task.target_title current_user.language
		@task.description = @task.target_description current_user.language
		taskResult = @task.lumniSave(params,current_user,list: current_user.template('ProjectTask','project_tasks',current_user))
		lumniClose(@task,taskResult)
	end

	def show_checklist
	end


	def done 
		@task = ProjectTask.full_task.cached_find(params[:id])
		project_id = @task.project_id
		card = ProjectCard.where(project_id: project_id,title: 'done').first
		@task.project_card_id = card.id
		@task.automatic_percentage = @task.progress
		@task.automatic_done = false
		@task.progress = 100
		@task.done = true
		@task.done_date = DateTime.now
		@task.save
	end

	def undone
		@task = ProjectTask.full_task.cached_find(params[:id])
		project_id = @task.project_id
		card = ProjectCard.where(project_id: project_id,title: 'under-review').first
		@task.project_card_id = card.id
		@task.progress = @task.automatic_percentage
		@task.automatic_done = false
		@task.done = false
		@task.done_date = nil
		@task.save
	end

	def update_card
		@task = ProjectTask.full_task.cached_find(params[:id])
		@project = @task.project_card.project
		@card = @project.project_card.find_by_title(params[:card])
		@task.project_card_id = @card.id

		if @card.title == 'done'
			@task.done = true
			@task.progress = 100
		end
		@task.save
	end

	def show_project_tab
		@project = Project.cached_find(params[:id])
	end

	def check_read_task
		task = ProjectTask.full_task.cached_find(params[:id]).update(read_check: true)
	end

	def uncheck_read_task
		task = ProjectTask.full_task.cached_find(params[:id]).update(read_check: false)
	end


end
