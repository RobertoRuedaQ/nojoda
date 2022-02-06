class MentoryEmpleabilityService
  def self.for(user_id)
    new(user_id).perform
  end

  def initialize(user_id)
    @user = User.find(user_id)
  end

  def perform
    application = Application.where(application_case: 'mentory_empleability_invitation', status: 'active').where(user_id: @user.id).first
    if application.nil?
      invitation = MentoryEmpleabilityInvitation.create(user_id: @user.id)
      application = Application.create({status: 'active',user_id: @user.id,application_case: 'mentory_empleability_invitation',resource_type: 'MentoryEmpleabilityInvitation', resource_id:invitation.id })
    end
  end

  
end