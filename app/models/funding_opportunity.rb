class FundingOpportunity < ApplicationRecord
  resourcify
  audited
  
  scope :from_country,->(company_id){joins(:fund).where(funds:{company_id: company_id})}
  scope :full_funding_opportunity,->{includes(:funding_disbursement, :funding_token,:funding_opportunity_team)}
  scope :active_funding_opportunities, ->(company_ids){joins(:fund).where(status: 'in_progress', funds: {company_id: company_ids}).kept }  
  
  belongs_to :fund
  belongs_to :eligibility_criteria, class_name: "LegalDocument",foreign_key: 'eligibility_criteria_id',optional: true
  belongs_to :origination, optional: true
  belongs_to :contract_young, class_name: 'LegalDocument',foreign_key: 'contract_young_id',optional: true
  belongs_to :contract_adult, class_name: 'LegalDocument',foreign_key: 'contract_adult_id',optional: true
  belongs_to :amendment_young, class_name: 'LegalDocument',foreign_key: 'amendment_young_id',optional: true
  belongs_to :amendment_adult, class_name: 'LegalDocument',foreign_key: 'amendment_adult_id',optional: true
  belongs_to :adult_promissory_note, class_name: 'LegalDocument',foreign_key: 'adult_promissory_note_id',optional: true
  belongs_to :young_promissory_note, class_name: 'LegalDocument',foreign_key: 'young_promissory_note_id',optional: true
  belongs_to :amendment_blackrock, class_name: 'LegalDocument',foreign_key: 'blackrock_ammendment_id',optional: true
  belongs_to :invite_template, class_name: 'LegalDocument',foreign_key: 'invite_template_id',optional: true
  
  belongs_to :modeling, optional: true
  belongs_to :interview, class_name: 'Questionnaire',foreign_key: 'interview_id',optional: true
  has_many :application, as: :resource , dependent: :destroy
  
  #  has_many :application, dependent: :destroy
  has_many :funding_opportunity_team, dependent: :destroy
  has_many :funding_opportunity_invitation, ->{kept},dependent: :destroy
  has_many :funding_token,->{kept}, dependent: :destroy
  has_many :isa,dependent: :destroy
  
  
  has_one :funding_disbursement,dependent: :destroy
  has_one :payment_config, dependent: :destroy
  has_one :disbursement_origination, dependent: :destroy
  
  has_one :academi_origination, dependent: :destroy
  has_one :process_origination, dependent: :destroy
  
  after_create :initialize_funding_disbursement
  
  
  def active_questionnaire
    nil
  end
  
  def closed_type?
    self.opportunity_type == 'closed'
  end
  
  def verified? user_id
    self.funding_token.where(user_id: user_id).count > 0
  end
  
  def contract_ids
    [self.contract_adult_id, self.contract_young_id, self.amendment_young_id, self.amendment_adult_id].compact
  end
  
  def initialize_funding_disbursement
    FundingDisbursement.create(funding_opportunity_id: self.id)
    PaymentConfig.create(funding_opportunity_id: self.id)
    DisbursementOrigination.create(funding_opportunity_id: self.id)
    AcademiOrigination.create(funding_opportunity_id: self.id)
    ProcessOrigination.create(funding_opportunity_id: self.id)
  end
  
  def company
    self.fund.company
  end
  
  def company_id
    self.fund.company.id
  end
  
  def eligibility_text
    self.eligibility_criteria.body.html_safe
  end
  
  def fund_name
    self.fund.name
  end
  
  def t_status
    I18n.t('list.' + self.status)
  end
  
  def assigned_supervisor
    supervisor_ids = FundingOpportunityTeam.where(funding_opportunity_id: self.id).map{|t| t.user_id}
    target_supervisor = TeamSupervisor.select(:supervisor_id).joins(:team_member).where(supervisor_id: supervisor_ids,users:{type_of_account: "student"}).group(:supervisor_id).size
    new_supervisor = supervisor_ids - target_supervisor.keys
    new_supervisor.each do |n_super|
      target_supervisor[n_super] = 0
    end
    return Hash[target_supervisor.sort_by{|k, v| v}].keys.first
  end

  def can_request_emergency_black_rock?
    self.emergency_black_rock == true
  end
end
