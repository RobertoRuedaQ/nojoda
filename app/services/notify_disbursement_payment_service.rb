class NotifyDisbursementPaymentService
  def self.for(user_id)
    user = User.find(user_id)
    return if user.nil?
    new(user).perform
  end

  def initialize(user)
    @user = user
  end

  def perform
    notify_to_student_the_payment_of_disbursement
  end

  private

  def notify_to_student_the_payment_of_disbursement
  project = @user.projects.select{|project| project.person_project == true}.first
	project_card = project.project_card.select{|project_card| project_card.position == 0}.first
	task = ProjectTask.create({
    title: "Desembolso pagado",
    description: "#{@user.full_name}, el desembolso que solicitaste ha sido pagado. Revisa tu correo electrónico para encontrar el documento soporte.",
    deadline: Time.now.to_date + 3.days, 
    responsable_id: @user.id,
    created_by_id: @user.id,
    project_task_type_id: 1,
    project_card_id: project_card.id, 
    start_date: Time.now.to_date,
    task_source: "accounting",
    priority: "medium", 
    task_case: "draft",
    requirement_type: "disbursement"
  })
  Notification.create({notification_case_id: 1, resource_type: 'ProjectTask',resource_id: task.id, user_id: @user.id})
  end
end