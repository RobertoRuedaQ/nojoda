class TeamProfile < ApplicationRecord
  resourcify
  rolify
  has_many :team_approval, dependent: :destroy
  has_many :team_profile_template, dependent: :destroy

  after_commit :flush_cached_roles
  after_create :add_profile_permissions

  def add_profile_permissions
    target_actions= ['view','create','update']
    target_models = [Profile,ContactInfo,Location,PersonalInformation,LegalMatch,UserQuestionnaire,UserQuestionnaireAnswer,
      ApplicationSectionTrack,ModelingMatch,Notification,StudentAcademicInformation,SchoolInfo,UniversityInfo,StudentFinancialInformation,
      Feedback,BillingDocument,Payment,PaymentAgreement,PaymentMatch,BillingDocumentDetail,BillingDocumentMatch,FundingOpportunityInvitation,
      Searcher,IncomeVariableIncome]
    target_models.each do |target_model|
      target_actions.each do |action|
        self.add_role action, target_model
      end
    end

    target_actions= ['view','create','update']
    target_models = [Profile,ContactInfo,Location,PersonalInformation,LegalMatch,UserQuestionnaire,UserQuestionnaireAnswer,
      ApplicationSectionTrack,ModelingMatch,Notification,StudentAcademicInformation,SchoolInfo,UniversityInfo,StudentFinancialInformation,
      Feedback,BillingDocument,Payment,PaymentAgreement,PaymentMatch,BillingDocumentDetail,BillingDocumentMatch,FundingOpportunityInvitation,
      Searcher,IncomeVariableIncome, CancellationConfig]
    TeamProfile.kept.each do |profile|
      target_models.each do |target_model|
        target_actions.each do |action|
          profile.add_role action, target_model
        end
      end
    end

  end




  def cached_roles
	Rails.cache.fetch([self.name, 'roles']) {roles.to_a}
  end


  def cached_role_names
    Rails.cache.fetch([self.name,'role_names']) {cached_roles.map{|role| role.role_name}.flatten}
  end

  def flush_cached_roles
  	Rails.cache.delete([self.name,'roles'])
  	Rails.cache.delete([self.name,'role_names'])
  end


  def role_id role,model
    model = model.to_s.singularize.camelize
    targetRole = self.roles.where(name: role.to_s, resource_type: model.to_s)
    if targetRole.count > 0
      targetRole.first.id
    else
      nil
    end
  end



  def role_approver_id role, model

    tempRoleId = self.role_id role, model
    begin
      Rails.cache.fetch([self.id,role,model,'role_approver_id']){TeamApproval.find_by_role_id(tempRoleId).team_profile_id}
    rescue 
      Rails.cache.fetch([self.id,role,model,'role_approver_id']){nil}
    end
  end

  def approvers_hash
    tempHash = {}
    total_approvers = self.roles.joins(:team_approval)
    total_approvers.each do |role|
      tempName = role.role_name.split('_with_approval').first + '_approver'

      tempHash[tempName.to_sym] = role.approver_id
    end
    return tempHash
  end

  def template_array
    final_array = []
    self.team_profile_template.each_with_index do |template,index|
      final_array[index] = [self.cached_objects[template.id], template.controller_name, template.form_template_id]
    end
    return final_array
  end


  def cached_objects
    Rails.cache.fetch([self.id,'cached_objects']){objects}
  end

  def objects
    object_hash = {}
    self.team_profile_template.each do |template|
      object_hash[template.id] = template.object
    end
    return object_hash
  end







end
