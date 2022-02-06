class Disbursement < ApplicationRecord
      
      resourcify
      audited
  belongs_to :funding_option, optional: true
  belongs_to :application, optional: true
  belongs_to :student_academic_information, optional: true
	belongs_to :resource, polymorphic: true, optional: true
  belongs_to :isa, optional: true,touch: true
	has_many :condonation,->{kept},dependent: :destroy
	has_many :disbursement_application,->{kept},class_name: 'Application', as: :resource , dependent: :destroy
  has_many :disbursement_request, through: :disbursement_application, source: :disbursement_request
  has_many :payment_match, through: :disbursement_request, source: :payment_match
  has_many :payment, through: :payment_match, source: :payment
  has_many :user_questionnaire,->{kept}, as: :resource, dependent: :destroy
  has_many :disbursement_match,->{kept}, dependent: :destroy
  has_many :disbursement_payment,->{kept}, dependent: :destroy
  has_many :disbursement_cancellation,->{kept}, dependent: :destroy
  has_many :funding_option_disbursement, dependent: :destroy
  has_many :total_funding_option, through: :funding_option_disbursement, source: :funding_option
  has_one :processed_application, ->{where(status: ['active','submitted','approved'])},class_name: 'Application', as: :resource 
  has_one :cancellation_request, dependent: :destroy
  has_one :cancellation_application, through: :cancellation_request, source: :application
  has_one :university_grade, foreign_key: :academic_bonus_id, dependent: :nullify

  scope :active_disbursement,->{joins(:disbursement_payment).where(disbursement_payments: {status: ['waiting_for_university_support','sent_to_account','sent_to_bank','payed']})}

  before_save :set_valuation_value_and_summary
  after_commit :attach_isa, on: [:create,:update]
  after_commit :update_stored_status, on: [:create,:update]
  after_create :migrate_disbursement
  after_touch :touch_cached_disbursement_values

  after_commit :set_scholarship, on: [:create,:update]

  after_commit :generate_emergency_living_expenses_payment_agreement, on: :update, if: :payed?

  def active_funding_option
    FundingOption.joins(:disbursement,:isa).find_by('disbursements.id =?',self.id)
  end

  def apply_cancellations_after_disbursement
    general_after_disbursement_cancellation_formula self.cancellation_after_disbursement_config
    self.total_funding_option.map(&:touch)
  end

  def payment_dates
    self.disbursement_payment.pluck(:payment_date).join(',')
  end

  def cancellation_under_review?
    self.cancellation_application.present? && self.cancellation_application.status == 'submitted'
  end

  def pending_after_disbursement_cancellation?
    self.pending_after_disbursement_cancellation.any?
  end


  def pending_after_disbursement_cancellation
    self.cancellation_after_disbursement_config.where.not(record_type: self.disbursement_cancellation.pluck(:cancellation_case)) 
  end

  def cancellation_after_disbursement_config
    self.cancellation_config.where(ejecution_type: 'disbursement',cancellation_type: self.disbursement_case)
  end

  def cancellation_after_graduation_config
    self.cancellation_config.where(ejecution_type: 'graduation',cancellation_type: self.disbursement_case)
  end


  def scholarship_config
    self.cancellation_config.find_by(ejecution_type: "scholarship",cancellation_type: self.disbursement_case)
  end


  def payed?
    self.status == 'payed'
  end

  def generate_emergency_living_expenses_payment_agreement
    EmergencyLivingExpensesPaymentAgreementService.for(self)
  end

  def set_scholarship
    general_after_disbursement_cancellation_formula self.scholarship_config
  end

  def general_after_disbursement_cancellation_formula target_configs
    target_configs = [] if target_configs.nil?
    target_configs.each do |cancellation|
      if self.cancellation_request.validate_cancellation_config cancellation
        temp_cancellation =  self.disbursement_cancellation.find_or_create_by(cancellation_config_id: cancellation.id, status: 'active')
        expected_cancellation = [[(self.adjusted_student_value * cancellation.cancellation_percentage.to_f / 100).round, 
                                        (self.adjusted_student_value * cancellation.max_general.to_f / 100 - self.disbursement_cancellation.where.not(cancellation_config_id: cancellation.id).sum(:value)).round].min,0].max
        if temp_cancellation.value.to_f != expected_cancellation
          temp_cancellation.update({cancellation_case: cancellation.record_type, value: expected_cancellation})
        end
      else
        temp_cancellation =  self.disbursement_cancellation.find_by(cancellation_config_id: cancellation.id)
        if temp_cancellation.present?
          temp_cancellation.destroy
        end
      end
    end
  end

  def pending_cancellation_process?
    self.stored_general_status == 'payed' && !self.disbursement_cancellation.any? && self.cancellation_config.any? && (self.cancellation_application.nil? || ['active','submitted'].include?(self.cancellation_application.status))
  end

  def cancellation_config
    self.fund.cancellation_config
  end


  def touch_cached_disbursement_values
    # Disbursement.where('payed_by_student IS NULL OR requested IS NULL OR approved IS NULL OR compromised IS NULL OR disbursed IS NULL OR disbursement_process IS NULL OR canceled IS NULL OR adjusted_student_value IS NULL').select(:id).all.each do |d|
    #   ModelClassesAsync.perform_async('Disbursement', 'touch_cached_disbursement_values', d.id)
    # end
    self.update_column('payed_by_student',self.payed_by_student_logic)
    self.update_column('canceled',self.canceled_logic)
    self.update_column('adjusted_student_value',self.adjusted_student_value_logic)
    self.update_column('requested',self.requested_logic)
    self.update_column('approved',self.approved_logic)
    self.update_column('compromised',self.compromised_logic)
    self.update_column('disbursed',self.disbursed_logic)
    self.update_column('disbursement_process',self.disbursement_process_logic)
  end



  def set_valuation_value_and_summary
    self.payed_by_student = self.payed_by_student_logic
    self.canceled = self.canceled_logic
    self.adjusted_student_value = self.adjusted_student_value_logic
    self.valuation_value = [self.adjusted_student_value.to_f - self.canceled.to_f - self.payed_by_student.to_f,0].max
    self.requested = self.requested_logic
    self.approved = self.approved_logic
    self.compromised = self.compromised_logic
    self.disbursed = self.disbursed_logic
    self.disbursement_process = self.disbursement_process_logic
  end


  def total_payed
    self.disbursement_payment.where(status: 'payed').sum(:value)
  end


  def self.payed_total_value
    self.includes(:disbursement_payment).where(status: 'payed').map{|d| d.disbursement_payment.sum(:value)}.compact.inject(:+).to_f
  end

  def self.approved_total_value
    self.includes(:disbursement_match).where(status: 'approved').map{|d| d.disbursement_match.sum(:values)}.compact.inject(:+).to_f
  end
  def self.pending_total_value
    self.includes(:disbursement_payment).where(status: ['generated','requesting','active']).sum(:value)
  end

  def self.total_student_value
    self.payed_total_value + self.approved_total_value + self.pending_total_value
  end

  def canceled_logic
    self.disbursement_cancellation.where(status: 'active').sum(:value)
  end

  def adjusted_student_value_logic
    case self.status
    when 'payed'
      result = self.disbursement_payment.where(status: 'payed').sum(:value) - self.payed_by_student.to_f
    when 'approved'
      result = self.disbursement_match.sum(:values)
    when 'generated','requesting','active'
      result = self.student_value
    end
    result.to_f
  end


  def migrate_disbursement
    # ModelClassesAsync.perform_async('Disbursement', 'migrate_disbursement', disbursement.id)

    FundingOptionDisbursement.find_or_create_by(disbursement_id: self.id, funding_option_id: self.funding_option_id )
  end


  def force_activation
    # Application
    application = Application.create({  status: 'active',user_id: self.funding_option.isa.user_id, application_case: 'disbursement_request', resource_type: 'Disbursement', resource_id: self.id})
    # Disbursement Request
    disbursement_request = DisbursementRequest.create({application_id: application.id, tuition_value: self.student_value, status: 'active', due_date: Time.now.to_date, request_case: 'student_request', tuition_funded_percentage: 100.0, disbursement_value: self.student_value, disbursement_case: 'college_tuition_payment', tuition_due_date_type: 'Ordinaria'})
    # Approve application
    application.update({ result: 'approved', status: 'pending', decision: 'approved'})
    # Disbursement Payment
    DisbursementPayment.create({disbursement_id: self.id, disbursement_request_id: disbursement_request.id, value: self.student_value, status: "payed"})

    # Update Disbursement status
    self.update(status: 'approved')

  end

  def payed_by_student_logic
    self.student_payments.pluck(:value).reduce(:+)
  end

  def student_payments
    PaymentMatch.joins(disbursement_request: :application).where(disbursement_requests: {applications: {resource_type: 'Disbursement', resource_id: self.id}}).uniq
  end

  def funding_opportunity
    Rails.cache.fetch(['funding_opportunity_for_disbursement',self.id]){funding_option.right_application.funding_opportunity}
  end

  def fund
    Rails.cache.fetch(['fund_for_disbursement',self.id]){funding_opportunity.fund}
  end

  def user
    Rails.cache.fetch(['user_for_disbursement',self.id],expires_in: 8.days){funding_option.right_application.user}
  end

  def cancellantion_scholarship
    self.disbursement_cancellation.where(cancellation_case: 'scholarship',status: 'active').sum(:value)
  end

  def cancellation_performance
    self.disbursement_cancellation.where(cancellation_case: 'performance',status: 'active').sum(:value)
  end

  def cancellation_performance_and_graduation
    self.disbursement_cancellation.where(cancellation_case: 'performance_and_graduation',status: 'active').sum(:value)
  end

  def cancellation_graduation
    self.disbursement_cancellation.where(cancellation_case: 'graduation',status: 'active').sum(:value)
  end

  def non_scholarship_cancelation
    self.disbursement_cancellation.where(status: 'active').sum(:value)
  end


  def reset_this_disbursement
    self.disbursement_payment.destroy_all
    self.disbursement_match.destroy_all
    self.user_questionnaire.destroy_all
    self.condonation.destroy_all
    self.disbursement_application.destroy_all
    self.update(status: 'active', stored_general_status: 'active')
  end

  def update_stored_status
    if self.stored_general_status != self.disbursement_status
      self.update(stored_general_status: self.disbursement_status)
    end
  end


  def disbursement_status
    if self.disbursed  == self.approved && self.approved > 0
      result = 'payed'
    elsif self.disbursed > 0
      result = 'partially_payed'
    elsif self.disbursement_payment.account_payments.count > 0
      result = 'in_payment_process'
    elsif self.approved > 0
      result = 'approved'
    elsif self.requested > 0
      result = 'requested'
    elsif self.status == 'active'
      result = 'active'
    elsif self.status == 'canceled'
      result = 'canceled'
    else
      result = 'inactive'
    end
  end

  def attach_isa
    if self.isa_id.nil? && self.disbursement_payment.to_active_isa.count > 0
      self.isa_id = self.funding_option.isa.id
      self.save
    end
  end

  def approved_amount
    result = 0
    if !self.approved_application.nil? 
      result = self.approved_application.disbursement_request.disbursement_value.to_f
    end
    return  result
  end



  def associated_living_expenses
    if self.disbursement_case != 'living_expenses'
      following_disbursement = self.following_disbursement
      if following_disbursement.nil?
        target_living_expenses = self.funding_option.disbursement.where.not(id: self.id).where(disbursement_case: 'living_expenses').where('forcasted_date >= ?',self.forcasted_date).order(:disbursement_number)
      else
        target_living_expenses = self.funding_option.disbursement.where.not(id: self.id).where(disbursement_case: 'living_expenses').where('forcasted_date >= ?',self.forcasted_date).where('forcasted_date < ?',following_disbursement.forcasted_date).order(:disbursement_number)
      end
    else
      target_living_expenses = []
    end
    target_living_expenses
  end

  def following_disbursement
    Disbursement.find_by(disbursement_case: self.disbursement_case,funding_option_id: self.funding_option_id,disbursement_number: (self.disbursement_number + 1))
  end



  def requested_logic
    if self.processed_application.nil? || self.processed_application.disbursement_request.nil?
      result = 0
    else
      result = self.processed_application.disbursement_request.disbursement_value.to_f
    end
    return result
  end

  def approved_logic
    result = 0
    if self.disbursement_match.any? && self.approved_application.present? && self.approved_application.disbursement_request.present?
      result = DisbursementMatch.joins(:disbursement).where(disbursement_request_id: self.approved_application.disbursement_request.id).where(disbursements: {disbursement_case: self.disbursement_case}).sum(:values)
    elsif self.disbursement_case == "living_expenses" && self.disbursement_match.sum(:values) > 0
      result = self.active_match.sum(:values)
    end
    return result
  end

  def compromised_logic
    self.disbursement_match.sum(:values)
  end

  def disbursed_logic
    self.disbursement_payment.where(status: 'payed').sum(:value)
  end

  def disbursement_process_logic
    case status 
    when 'canceled'
      0
    else
      self.disbursement_payment.where.not(status: 'payed').sum(:value)
    end
  end

  def free
    self.student_value.to_f - self.compromised.to_f
  end

  def available
    self.free
  end

  def available_for_request_in_advance
    percentage_next_tuition = self.funding_opportunity.disbursement_origination.percentage_next_tuition.to_f
    self.student_value * percentage_next_tuition / 100
  end

  def active_questionnaire
    result = nil
    if self.submitted_application.present? && self.submitted_application.questionnaire_review.present?
      result = self.submitted_application.questionnaire_review.id
    end
    return result
  end

  def current_application
    self.disbursement_application.find_by_status('active')
  end
  def submitted_application
    self.disbursement_application.find_by_status('submitted')
  end

  def approved_application
    Application.joins(disbursement_request: :disbursement_match).where(disbursement_matches: {disbursement_id: self.id}).where(status: 'approved', resource_type: "Disbursement", resource_id: self.id).last
  end

	def with_active_application?
		!self.active_application.nil?
	end

  def active_application
    self.disbursement_application.find_by_status('active')
  end

  def active_match
    self.disbursement_match.joins(disbursement_request: :application).where('applications.status = ?',"approved")
  end

  def application_from_match
    if self.active_match.count > 0
      self.active_match.last.disbursement_request.application
    end
  end








  # Elements to get applications working (start)

  def origination
    case self.disbursement_case
    when 'living_expenses'
      origination = self.origination_living_expenses
    when 'emergency_living_expenses'
      origination = self.origination_emergency_living_expenses
    when 'academic_bonus'
      origination = self.origination_academic_bonus
    else
      origination = self.origination_tuition
    end
    return origination
  end
  # Elements to get applications working (End)


  def company
  	self.application.company
  end

  def origination_tuition
  	self.funding_opportunity.disbursement_origination.origination_tuition
  end

  def origination_living_expenses
  	result = self.funding_opportunity.disbursement_origination.origination_living_expenses
    if result.nil?
      result = self.origination_tuition
    end
    return result
  end

  def origination_emergency_living_expenses
  	result = self.funding_opportunity.disbursement_origination.origination_emergency
    if result.nil?
      result = self.origination_tuition
    end
    return result
  end

  def origination_academic_bonus
    result = self.funding_opportunity.disbursement_origination.origination_bonus
    if result.nil?
      result = self.origination_tuition
    end
    return result
  end


  def questionnaire_tuition
    self.funding_opportunity.disbursement_origination.review_tuition
  end

  def questionnaire_living_expenses
    self.funding_opportunity.disbursement_origination.review_living
  end

  def user_supervisor_in_charge
    self.student_academic_information.user.supervisor_in_charge unless self.student_academic_information.user.nil?
  end

  def user_fund
    self.student_academic_information.user.fund unless self.student_academic_information.user.nil?
  end

  def user_belongs_to_funding_opportunity
    self.student_academic_information.user.funding_opportunity_belongs unless self.student_academic_information.user.nil?
  end

  def user_identification_number
    self.student_academic_information.user.identification_number unless self.student_academic_information.user.nil?
  end

  def user_first_name
    self.student_academic_information.user.first_name unless self.student_academic_information.user.nil?
  end

  def user_last_name
    self.student_academic_information.user.last_name unless self.student_academic_information.user.nil?
  end

  def user_email
    self.student_academic_information.user.email unless self.student_academic_information.user.nil?
  end

  def major_name
    self.student_academic_information.major.name unless self.student_academic_information.user.nil?
  end

  def institution_bank_acount_number
    self.student_academic_information.institution.bank_account.first.account_number unless self.student_academic_information.institution.bank_account.first.nil?
  end

  def institution_bank_account_case
    self.student_academic_information.institution.bank_account.first.account_case unless self.student_academic_information.institution.bank_account.first.nil?
  end

  def institution_bank_bank_name
    self.student_academic_information.institution.bank_account.first.bank_name unless self.student_academic_information.institution.bank_account.first.nil?
  end

  def user_account_number
    self.student_academic_information.user.bank_account.account_number unless self.student_academic_information.user.bank_account.nil? 
  end

  def user_account_case
    self.student_academic_information.user.bank_account.account_case unless self.student_academic_information.user.bank_account.nil?
  end

  def user_bank_name
    self.student_academic_information.user.bank_account.bank_name unless self.student_academic_information.user.bank_account.nil?
  end

  def disbursement_payment_support
    support = self.disbursement_payment.select{|dp|dp.payment_support.attached?}
    support.any? ? support.map{ |s| s.payment_support.service_url} : 'n/a'
  end

  def do_payment
    disbursement = self
    user = disbursement.user
    funding_option = disbursement.funding_option
  
    application_for_disbursement = Application.find_or_create_by({ 
        status: 'active',
        user_id: user.id, 
        application_case: 'disbursement_request', 
        resource_type: 'Disbursement', 
        resource_id: disbursement.id
        })
  
  
      disbursement_request = DisbursementRequest.find_or_create_by({
        application_id: application_for_disbursement.id,
        tuition_value: disbursement.student_value, 
        status: 'active', 
        due_date: Time.now.to_date, 
        request_case: 'student_request', 
        tuition_funded_percentage: 100.0, 
        disbursement_value: disbursement.student_value, 
        disbursement_case: 'college_tuition_payment', 
        tuition_due_date_type: 'Ordinaria'
        })
  
      DisbursementMatch.find_or_create_by({
          disbursement_id: disbursement.id, 
          disbursement_request_id: disbursement_request.id, 
          values: disbursement.student_value
        })
      application_for_disbursement.update({ status: 'approved'})
  
      DisbursementPayment.find_or_create_by({
        disbursement_id: disbursement.id, 
        disbursement_request_id: disbursement_request.id, 
        value: disbursement.student_value,
        payment_date: DateTime.now,
        status: "payed"
        })
  
      disbursement.update(status: 'payed', stored_general_status: 'payed')
      funding_option.touch_cache_variables
      disbursement.touch_cached_disbursement_values
    end
end
