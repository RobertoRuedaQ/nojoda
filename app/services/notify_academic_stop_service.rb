class NotifyAcademicStopService
  def self.for(user_id, current_user_id)
    new(user_id, current_user_id).perform
  end

  def initialize(user_id, current_user_id)
    @user = User.find(user_id)
    @current_user = User.find(current_user_id)
  end

  def perform
    notify_student
    create_collection_record
  end

  private

  def notify_student
    student_project = @user.projects.select{|project| project.person_project == true}.first
		student_project_card = student_project.project_card.select{|project_card| project_card.position == 0}.first
		student_task = ProjectTask.create({
			title: "Se ha aceptado tu pausa académica",
			description: "Hola #{@user.full_name}, tu solicitud de aplazamiento académico ha sido aceptada.",
			deadline: Time.now.to_date + 1.days, 
			responsable_id: @user.id,
			created_by_id: @current_user.id,
			project_task_type_id: 1,
			project_card_id: student_project_card.id, 
			start_date: Time.now.to_date,
			task_source: "academic stage",
			priority: "medium", 
			task_case: "draft",
			requirement_type: "account_statuses"
		})
		Notification.create({notification_case_id: 1, resource_type: 'ProjectTask',resource_id: student_task.id, user_id: @user.id})
  end

  def create_collection_record
    Collection.create(user_id: @user.id, stage: "academic", contact_person: "student", communication_chanel: "email", action: "postponement", case: "efective", result: "will_postpone", following_date: Time.now.to_date, comments: "#{@current_user.full_name} ha aceptado la solicitud del estudiante de una pausa académica. Este mensaje es automáticamente creado por la plataforma.", status: "active", owner_id:  @current_user.id )
  end


end