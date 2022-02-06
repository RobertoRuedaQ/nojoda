class Collection < ApplicationRecord
      
  resourcify
  audited

  belongs_to :user
  belongs_to :owner, class_name: 'User',foreign_key: 'owner_id'
  has_one_attached :support_document

  after_commit :validate_collection

  def user_name
  	self.user.name
  end

  def owner_name
    self.owner.present? ? self.owner.name : ''    
  end

  def validate_collection
    set_employment_status_from_collection
  end

  def set_employment_status_from_collection
    return unless (self.stage == 'production' && self.action == 'update_job_information')

    if ['suspension_for_late_payment', 'active'].include?(self.affiliation_status) && self.affiliation_type == 'contributing' &&  self.system == 'contributory'
      isa.set_employed_without_certificate(self.id)
    else
      isa.set_unemployed(self.id)
    end
  end


  def isa
    self.user.active_isa.first
  end
end
