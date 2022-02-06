module ProjectsHelper 

	def createProjectCard card
		if card.title == 'done'
			tasks = card.main_tasks.limit(25)
			show_more = true
		else
			tasks = card.main_tasks
			show_more = false
		end
		render '/projects/partials/cards', card: card, tasks: tasks, show_see_more: show_more
	end

	def createProjectTask task
		render '/projects/partials/tasks', task: task
	end
	def createProjectTaskBody task
		ac = ActionController::Base.new()
		@popover = ac.render_to_string('/projects/partials/popover',layout: false)
		render '/projects/partials/task_body', task: task
	end
	def showChecklist taskId
		@targetTask = ProjectTask.cached_find(taskId)
		render '/projects/partials/checklist'
	end

	def showChecklistElemnt taskId
		@targetTask = ProjectTask.cached_find(taskId)
		render '/projects/partials/checklist_body'
	end

	def projectDateCase start_date, deadline, done
		if done
			@deadlineCase = 'success' 
		elsif !deadline.nil?
			if start_date.nil?
				@days_left = (deadline.to_date - Time.now.to_date).to_i
				if @days_left > 2 
					@deadlineCase = 'primary' 
				elsif @days_left >= 0 
					@deadlineCase = 'warning' 
				else 
					@deadlineCase = 'danger' 
				end
			else
				@days_left = (deadline.to_date - Time.now.to_date).to_i
				if Time.now.to_date < start_date.to_date
					@deadlineCase = 'primary' 
				elsif Time.now.to_date >= start_date.to_date && Time.now.to_date <= deadline
					@deadlineCase = 'warning' 
				else 
					@deadlineCase = 'danger' 
				end
			end
		else
			@deadlineCase = 'primary'
		end
		return @deadlineCase
	end

	def showComment taskId
		@targetComments = ProjectComment.where(project_task_id: taskId)
		@targetTaskId = taskId
		@targetTask = ProjectTask.cached_find(taskId)
		render '/projects/partials/task_comment'
	end

	def createComment comment
		@comment = comment
		render '/projects/partials/comment_body'
	end

	def createProjectProgressPie project_id, scenario
		@scenario = scenario
		@project = Project.cached_find(project_id)
		
		case @scenario 
		when 'total_progress'
			@total_tasks = @project.cached_all_tasks(current_user.id).size
			@reference = @project.cached_all_tasks(current_user.id).sum(:progress).to_f/100
			@color = '#02BC77'
		when 'main_progress'
			@total_tasks = @project.cached_all_main_tasks(current_user.id).size
			@reference = @project.cached_all_main_tasks(current_user.id).sum(:progress).to_f/100
			@color = '#26B4FF'
		end
		@percentage = (@reference.to_f/@total_tasks.to_f*100).round(2)

		render 'projects/partials/progress'
	end

	def columns_at_project_list
		['read_check','title','cached_project_title','project_card_id','start_date','deadline','comments','responsable_id','created_by_id']
	end

	def create_project_list_view target_tasks, options={}
		render '/projects/partials/main_view_list', target_tasks: target_tasks
	end


	def create_project_list_element_view target_task, column
		begin
			list_element = target_task.send(column).to_s
		rescue 
			list_element = 'not defined'			
		end

		case column
		when 'created_by_id','responsable_id'
			list_element = content_tag :div, class: 'text-center p-1' do 
				loadingAvatar 20, id: list_element
			end
			list_element += content_tag :div, hidden: true, class: "#{column}" do 
				target_task.send(column.split('_id').first).name 
			end
		when 'project_card_id'
			card_title = target_task.project_card.title
			list_element = content_tag :div, class: 'text-center', style: 'min-width: 8rem' do 
				lumni_dropdown_field 'project','card_list',{list: project_cards_name_list, value: card_title, id: target_task.id}
			end
			list_element += content_tag :div, (card_title.gsub '-' ,' '),hidden: true ,class: column
		when 'start_date', 'deadline'
			list_element = content_tag :div, class: "m-1 badge badge-pill badge-#{projectDateCase(target_task.start_date,target_task.deadline,target_task.done)}" do
				target_task.send(column).to_s
			end
			list_element = content_tag :div, list_element, class: 'my-1 text-center'
			list_element += content_tag :div, target_task.send(column).to_s,hidden: true ,class: column
		when 'title'
			list_element = link_to( list_element , edit_task_project_task_path(target_task), class: 'text-body', remote: true, data: { disable_with: I18n.t('form.please_wait')} )
			list_element = content_tag :u, list_element
			list_element = content_tag :div, list_element, class: 'my-1'
			list_element += content_tag :div, target_task.title,hidden: true ,class: column

		when 'read_check'
			user_validation = target_task.responsable_id == current_user.id
			list_element = content_tag :div, class: 'text-center m-1', style: 'width: 2rem' do 
				lumni_boolean_field 'project','read_check',{ value: target_task.read_check, id: target_task.id, switcher_class: 'switcher-sm', switcher_input_class: 'project-list-read',disabled: !user_validation}
			end
			list_element += content_tag :div, target_task.read_check.to_s + (user_validation ? '1' : '2') ,hidden: true ,class: column
		when 'cached_project_title'
			list_element = content_tag :div, list_element, style: "min-width: 10rem", class: 'p-1'
		when 'comments'
			list_element =	button_to(show_chat_project_comment_path(target_task),method: 'get', class: 'btn btn-xs btn-outline-secondary borderless' ,tabindex: target_task.id+1, remote: true, data: {disable_with: I18n.t('general.loading')} ) do
          		('<i class="ion ion-ios-chatboxes"></i>' + target_task.project_comment.size.to_s).html_safe
          	end
          	list_element = content_tag :div, list_element, class: 'text-center'

		else
			list_element = content_tag :div, list_element,class: column + ' p-1 py-1'
		end


		return list_element.html_safe
	end
end
