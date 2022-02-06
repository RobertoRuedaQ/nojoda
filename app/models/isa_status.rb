class IsaStatus < ApplicationRecord
      
  resourcify
  audited

  belongs_to :isa, touch: true

  scope :start_status, -> (status_case,isa_id){where(phase: 'active',status_case: status_case,isa_id: isa_id).where('start_date <= ?', Time.now.to_date)}
  scope :potential_status, -> (status_case,isa_id){where(phase: ['active','pending'],status_case: status_case,isa_id: isa_id).where('start_date <= ?', Time.now.to_date)}
	scope :active_status_1, -> (status_case,isa_id){start_status(status_case, isa_id).where('end_date >= ?',Time.now.to_date)}
	scope :active_status_2, -> (status_case,isa_id){start_status(status_case, isa_id).where(end_date: nil)}
  scope :potential_status_1, -> (status_case,isa_id){potential_status(status_case, isa_id).where('end_date >= ?',Time.now.to_date)}
  scope :potential_status_2, -> (status_case,isa_id){potential_status(status_case, isa_id).where(end_date: nil)}


  after_create :keep_just_one_active_status
  before_commit :set_end_date



  def keep_just_one_active_status
    IsaStatus.active_status_1(self.status_case,self.isa_id).or(IsaStatus.active_status_2(self.status_case,self.isa_id)).where.not(id: self.id).update_all(phase: 'deactivated', end_date: Time.now.to_date)
  end

  def set_end_date
    if self.phase == 'deactivated' && self.end_date.nil?
      self.end_date = Time.now.to_date
    end
  end


  # employment_statuses
  UNEMPLOYED = 'unemployed'
  EMPLOYED = 'employed'
  EMPLOYED_WITH_PRESUMPTIVE_INCOME = 'employed_with_presumptive_income'
  EMPLOYED_WITHOUT_CERTIFICATE = 'employed_without_certificate'
  EMPLOYED_WITHOUT_VALID_INCOME = 'employed_without_valid_income'
end
