class PaymentMassDoc < ApplicationRecord
      
      resourcify
      audited
  belongs_to :payment_mass_detail, touch: true
  belongs_to :billing_document,optional: true
  belongs_to :disbursement_request,optional: true
  belongs_to :fund,optional: true
  has_one :payment, as: :resource , dependent: :destroy

  before_save :set_doc_value
  after_commit :flush_payment_mass_detail_cache
 
  scope :selected,->{where(status: 'selected')}

  def search_payment
    if !self.payment_mass_detail.external_id.nil?
      payment = Payment.find_by_external_id(self.payment_mass_detail.external_id)
      if !payment.nil? && payment.resource.nil?
        payment.update(resource_type: 'PaymentMassDoc',resource_id: self.id)
      end
    end
  end

  def user
    if self.billing_document.present?
      self.billing_document.isa.user
    elsif disbursement_request.present?
      self.disbursement_request.user
    end
  end

  def user_id
    self.user.id
  end

  def user_name
    self.user.name
  end

  def document_value
    if self.billing_document.present?
      self.billing_document.value
    end
  end

  def document_applied_value
    if billing_document.present?
      self.billing_document.applied_value
    end
  end

  def pending_value
    self.document_value.to_f - self.document_applied_value.to_f
  end


  def flush_payment_mass_detail_cache
    Rails.cache.delete(['n_matches_PaymentMassDetail',self.payment_mass_detail_id])
    Rails.cache.delete(['names_matches_PaymentMassDetail',self.payment_mass_detail_id])
    Rails.cache.delete(['funds_matches_PaymentMassDetail',self.payment_mass_detail_id])
  end

  def set_doc_value

    unless self.force_manual_value
      if !self.billing_document.nil?
        billing_document = self.billing_document.isa.billing_document.first
        self.billing_document_id = billing_document.id
        self.fund_id = self.billing_document.fund.id
        self.fund_name = self.billing_document.fund.name

      elsif !disbursement_request.nil?
        self.fund_id = self.disbursement_request.fund.id
        self.fund_name = self.disbursement_request.fund.name
      end

      if !self.fund.nil? && !self.payment_mass_detail.fund.nil?
        if self.fund_id != self.payment_mass_detail.fund_id
          account_correction = self.fund.bank_account.find_by(account_number: self.payment_mass_detail.bank_number)
          if account_correction.nil?
            self.status = 'rejected'
            if self.payment_mass_detail.matches_count == 1
              self.payment_mass_detail.update(problem_case: 'invalid_fund')
            end
          else
            self.payment_mass_detail.update(fund_id: self.fund_id) 
          end
        end
      end

      case self.payment_mass_detail.account_case
      when 'tuition'
        self.value = self.payment_mass_detail.value
      when 'repayment'
        if self.status == 'selected'
          if self.payment_mass_detail.matches_count == 1
            self.value =  self.payment_mass_detail.value_pending_to_apply(self.id)
          else
            self.value =  [[self.billing_document.pending_value,self.value.to_f].max,self.payment_mass_detail.value_pending_to_apply(self.id)].min
          end
        else
          self.value = [[self.billing_document.pending_value,self.value.to_f].max,self.payment_mass_detail.value_pending_to_apply(self.id)].min
        end
      end

      #Covid No Payment Rule
      if self.value == 0 && self.payment_mass_detail.matches_count == 1 && self.payment_mass_detail.payment_mass_id != 98
        if !self.billing_document.nil? && (self.billing_document.value == 0 || self.billing_document.value.nil? || self.billing_document.value == self.billing_document.applied_value)
          self.value = self.payment_mass_detail.value
          self.payment_mass_detail.update(problem_case: 'none')
        end
      end


    end

  end


end
