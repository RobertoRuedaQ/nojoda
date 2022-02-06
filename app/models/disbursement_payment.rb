class DisbursementPayment < ApplicationRecord
      
  resourcify
  audited
  belongs_to :disbursement, touch: true
  belongs_to :disbursement_request, touch: true
  belongs_to :bank_account, optional: true, touch: true

  scope :account_payments, ->{where(status: ['sent_to_account','sent_to_bank'])}
  scope :to_active_isa, ->{where(status: ['waiting_for_university_support','sent_to_account','sent_to_bank','payed'])}

  has_one_attached :payment_support

  after_commit :update_disbursement_status
  after_commit :notify_payment_to_student
  after_commit :update_student_xirr

  def update_disbursement_status
    if self.status == 'payed' && self.disbursement.status != 'payed'
      self.disbursement.update(status: 'payed')
    end
  end

  def notify_payment_to_student
    user = self.disbursement.user
    if self.tuition_disbursement_payed?
      PerformServiceAsync.perform_async('NotifyDisbursementPaymentService', user.id)
      CommunicationMailer.notify_disbursement_payment(user.id, user.company_id).deliver
    elsif self.living_expenses_disbursement_payed?
      CommunicationMailer.notify_living_expenses_disbursement_payment(user.id, user.company_id, self.id).deliver
    end
  end

  def update_student_xirr
    isa = self.disbursement.user.active_isa.first
    if self.tuition_disbursement_payed? || self.living_expenses_disbursement_payed?
      PerformServiceAsync.perform_async('UpdateXirrService', isa.id)
    end
  end


  def tuition_disbursement_payed?
    self.status == 'payed' && self.payment_support.attached? == true
  end

  def living_expenses_disbursement_payed?
    self.status == 'payed' && self.disbursement.disbursement_case == 'living_expenses'
  end
  

  def modeling_date
    self.payment_date.present? ? self.payment_date.to_date : self.disbursement.forcasted_date    
  end




  def bank_label
    if !self.bank_account.nil?
      @result = self.bank_account.account_label
    end
    return @result
  end

  def bank_account_name
    Rails.cache.fetch(['bank_account_for_disbursement_payment',self.bank_account_id]){bank_label}
  end


  def isa 
    Rails.cache.fetch(['disbursement_payment_isa',self.id],expires_in: 8.days){disbursement.funding_option.isa}
  end

  def user_name
    self.isa.user.name unless self.isa.nil?
  end


  def user_identification_number
    self.isa.user.identification_number unless self.isa.nil?
  end

  def fund_name
    self.isa.fund_name unless self.isa.nil?
  end

  def funding_opportunity_name
    self.isa.funding_opportunity_name
  end

  def value_payed_by_student
    if !disbursement_request.nil?
      @result = self.disbursement_request.value_payed_by_student
    end
    return @result
  end

  def institution_name
    self.disbursement.student_academic_information.institution.name
  end

  def disbursement_forcasted_date
    self.disbursement.forcasted_date
  end

  def tuitition_value
    self.disbursement_request.tuition_value
  end

  def value_payed_by_student
    self.disbursement_request.value_payed_by_student
  end

  def payment_target
    self.disbursement_request.payment_target
  end

  def disbursement_value
    self.disbursement_request.disbursement_value
  end

  def request_disbursement_date
    self.disbursement_request.created_at
  end
end
