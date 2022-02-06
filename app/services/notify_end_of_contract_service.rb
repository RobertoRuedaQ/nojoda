class NotifyEndOfContractService
  def self.for(user_id, supervisor_id)
    user = User.find(user_id)
    supervisor = User.find(supervisor_id) 
    return if user.nil?
    new(user, supervisor).perform
  end

  def initialize(user, supervisor)
    @user = user
    @supervisor = supervisor
  end

  def perform
    create_sm_project_task_notificaton
  end

  private

  def create_sm_project_task_notificaton
  project = @supervisor.projects.select{|project| project.person_project == true}.first
	project_card = project.project_card.select{|project_card| project_card.position == 0}.first
	task = ProjectTask.create({
    title: "Seguimiento terminación contrato de #{@user.full_name} - #{@user.id}",
    description: "Hacer el seguimiento al estudiante #{@user.full_name} con ID #{@user.id} de su finalización de contrato.",
    deadline: Time.now.to_date + 15.days, 
    responsable_id: @supervisor.id,
    created_by_id: @supervisor.id,
    project_task_type_id: 1,
    project_card_id: project_card.id, 
    start_date: Time.now.to_date,
    task_source: "productive stage",
    priority: "medium", 
    task_case: "draft",
    requirement_type: "employment_Information"
  })
  end
end