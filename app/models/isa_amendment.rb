class IsaAmendment < ApplicationRecord
      
      resourcify
      audited
  belongs_to :isa
  belongs_to :user
  has_many :isa_amendment_disbursement, dependent: :destroy
  before_create :keeping_just_one_amendment
  before_create :activate_new_record


	has_one_attached :support


  def user_name
  	self.isa.user_name
  end

  def activate_new_record
  	self.status = 'active'
  end

  def keeping_just_one_amendment
  	IsaAmendment.where(isa_id: self.isa_id, status: 'active').update_all(status: 'deactivated')
  end
  
end
