class RequestDiplomaService
  def self.for(user, current_user)
    new(user, current_user).perform
  end

  def initialize(user, current_user)
    @user = user
    @current_user = current_user
  end

  def perform
    create_sm_project_task
    notify_student
    create_collection_record
  end

  private

  def create_sm_project_task
  project = @current_user.projects.select{|project| project.person_project == true}.first
	project_card = project.project_card.select{|project_card| project_card.position == 0}.first
	task = ProjectTask.create({
    title: "Entrega del diploma del estudiante  #{@user.full_name} - #{@user.id}",
    description: "Hacer el seguimiento al estudiante #{@user.full_name} con ID #{@user.id} de su entrega del diploma. Al estudiante se le envió un correo electrónico",
    deadline: Time.now.to_date + 15.days, 
    responsable_id: @current_user.id,
    created_by_id: @current_user.id,
    project_task_type_id: 1,
    project_card_id: project_card.id, 
    start_date: Time.now.to_date,
    task_source: "productive stage",
    priority: "medium", 
    task_case: "draft",
    requirement_type: "graduation_certificate"
  })
  end

  def notify_student
    student_project = @user.projects.select{|project| project.person_project == true}.first
		student_project_card = student_project.project_card.select{|project_card| project_card.position == 0}.first
		student_task = ProjectTask.create({
			title: "Presentar diploma",
			description: "Hola #{@user.full_name}, según los datos de la plataforma ya se cumplió el plazo de la entrega del diploma. Favor revisa tu correo electrónico, te enviamos un mensaje con instrucciones de cómo hacerlo.",
			deadline: Time.now.to_date + 15.days, 
			responsable_id: @user.id,
			created_by_id: @current_user.id,
			project_task_type_id: 1,
			project_card_id: student_project_card.id, 
			start_date: Time.now.to_date,
			task_source: "productive stage",
			priority: "medium", 
			task_case: "draft",
			requirement_type: "graduation_certificate"
		})
		Notification.create({notification_case_id: 1, resource_type: 'ProjectTask',resource_id: student_task.id, user_id: @user.id})
  end

  def create_collection_record
    Collection.create(user_id: @user.id, stage: "production", contact_person: "student", communication_chanel: "email", action: "university_degree_tracking", case: "", result: "requested_title", following_date: Time.now.to_date, comments: "Se solicitó el diploma al estudiante mediante la notificación automática de la plataforma", status: "active", owner_id:  @user.id )
  end


end