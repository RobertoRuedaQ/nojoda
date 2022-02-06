class ProjectsController < ApplicationController
	def index
		@project = Project.active_projects(current_user.id)
		@archive_projects = Project.archived_projects(current_user.id)
		@favorite_projects = Project.active_projects(current_user.id).favorites(current_user.id)
		projectResult = @project.lumniSave(params,current_user)
		lumniClose(@project,projectResult)
	end

	def new
		@project = Project.lumniStart(params,current_company)
		projectResult = @project.lumniSave(params,current_user)
		lumniClose(@project,projectResult)
	end

	def create
		@project = Project.lumniStart(params,current_company)
		@project.owner = current_user
		projectResult = @project.lumniSave(params,current_user)
		setDefaults @project.id
		lumniClose(@project,projectResult)
	end

	def edit
		@project = Project.includes(:project_card,[project_card: :main_tasks]).lumniStart(params,current_company)
		projectResult = @project.lumniSave(params,current_user)
		unless @project.access_granted(current_user.id)
			projectResult = 'unauthorized'
		end
		lumniClose(@project,projectResult)

	end

	def update
		@project = Project.lumniStart(params,current_company)
		projectResult = @project.lumniSave(params,current_user)
		lumniClose(@project,projectResult)
	end
	def destroy
		@project = Project.lumniStart(params,current_company)
		projectResult = @project.lumniSave(params,current_user)
		lumniClose(@project,projectResult)
		@result =projectResult
	end

	def setDefaults projectId
		defaultCards = ['on-hold','in-progress','under-review','done']
		defaultCards.each_with_index do |card, index|
			tempCard = ProjectCard.create({title: card,position: index,project_id: projectId})
			puts 'tempCard.attributes' + tempCard.attributes.to_s
		end
	end

	def sort
		@tasks = ProjectTask.where(id: params[:sort])
		@tasks_parents = @tasks.map{|t| t.parent_id}.uniq.compact
		tempDate = nil
		if @tasks_parents.length == 0
			@card = ProjectCard.cached_find(params[:card])

			if @card.title == 'done'
				@tempParents = @tasks.where(automatic_done: false)
				@tempParents.cached_update_all('automatic_percentage=progress')
				@tempParents.cached_update_all(automatic_done: true, progress: 100)
				tempDate = DateTime.now
				@tempTasks = ProjectTask.where(parent_id: @tasks.ids, done: false)
				@tempTasks.cached_update_all('automatic_percentage=progress')
				@tempTasks.cached_update_all({done: true, automatic_done: true, progress: 100, done_date: tempDate, project_card_id: @card.id})

				tempAlreadyDone = ProjectTask.where(parent_id: @tasks.ids, done: true)
				tempAlreadyDone.cached_update_all(project_card_id: @card.id)
			else
				@tempParents = @tasks.where(automatic_done: true)
				@tempParents.cached_update_all('progress=automatic_percentage')
				@tempParents.cached_update_all(automatic_done: false)

				@tempTasks = ProjectTask.where(parent_id: @tasks.ids, automatic_done: true)
				@tempTasks.cached_update_all('progress=automatic_percentage')
				@tempTasks.cached_update_all({done: false, automatic_done: false, done_date: tempDate})
				ProjectTask.where(parent_id: @tasks.ids, done: false).cached_update_all({project_card_id: @card.id})
			end
			eval(params[:model]).update(params[:sort],(1..params[:sort].length).map{ |o |{position: o, project_card_id: @card.id , done_date: tempDate }})
		else
			puts 'second order case'
			eval(params[:model]).update(params[:sort],(1..params[:sort].length).map{ |o |{position: o }})
		end

	end

	def select_favorite
		@project = Project.cached_find(params[:id])
		@project.set_favorite(current_user.id)
	end

	def deselect_favorite
		@project = Project.cached_find(params[:id])
		@project.remove_favorite(current_user.id)
	end


end