class TeamSupervisor < ApplicationRecord
  resourcify
  audited
  belongs_to :supervisor, class_name: 'User',foreign_key: 'supervisor_id', touch: true
  belongs_to :team_member, class_name: 'User',foreign_key: 'team_member_id', touch: true

  belongs_to :support_role, optional: true
  
  validate :support_role_allowed?, on: :create

  def supervisor_name
    self.supervisor.name
  end

  def team_member_name
  	self.team_member.name
  end

  def support_name
  	self.support_role.role_case
  end


  def support_role_allowed?
    error_message = I18n.t('team_supervisor_batch.flash.create.invalid_support_role', { support_role: I18n.t("support_roles.#{support_name}") , team_member_id: team_member_id})
    
    case support_role_id
    when 3 # work
      errors.add(:support_role, error_message) unless team_member.work_stage?
    when 2 # academic 
      errors.add(:support_role, error_message) unless team_member.academic_stage?
    end
  end
end
