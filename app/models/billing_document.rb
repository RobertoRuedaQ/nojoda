class BillingDocument < ApplicationRecord
      
  resourcify
  audited
  belongs_to :isa, touch: true
  belongs_to :payment_batch
  has_many :billing_document_match,->{kept}, as: :resource, dependent: :destroy
  has_many :payment_agreement,->{kept}, dependent: :destroy
  has_many :payment, dependent: :destroy
  has_many :payu_transactions, dependent: :destroy
  has_many :mercado_pago_transactions, dependent: :destroy
  has_many :covid_emergency,dependent: :destroy
  has_many :payment_mass_detail, dependent: :destroy
  has_many :payment_mass_doc, dependent: :destroy
  has_many :income_variable_income, dependent: :destroy
  has_many :payment_match, through: :billing_document_match, source: :payment_match

  has_many :billing_document_detail,->{kept.order(reference_date: :desc)}, through: :billing_document_match

  #  default_scope includes(billing_document_match: [billing_document_detail: [:penalties, payment_match: :payment]])

  before_save :update_document_status
  after_commit :set_reference_date, except: :destroy
  after_commit :keep_one_document_active, except: :destroy
  after_touch :touch_status

  after_commit :set_variable_income

  def set_variable_income
    if self.fund.automatic_variable_income
      active_income = self.user.active_income_information

      self.income_variable_income.where.not(income_information_id: active_income.ids).destroy_all
      current_ids = self.income_variable_income.pluck(:income_information_id)
      pending_records = active_income.select{|i| i if !current_ids.include?(i.id) }

      pending_records.each do |income|
        IncomeVariableIncome.create(income_information_id: income.id, billing_document_id: self.id,value: income.variable_income.to_f,status: 'active' )
      end
    end
  end

  def variable_income
    self.income_variable_income.sum(:value)
  end

  def refresh
    self.isa.generate_billing_document self.payment_batch
  end

  def self.billing_by_identification_number identification_number
    BillingDocument.joins(isa: [user: :personal_information]).where(active: true).where(isas: {users: {personal_informations: {identification_number: identification_number}}}).first
  end

  def self.billing_by_bank_account_number bank_account_number
    BillingDocument.joins(isa: [user: :bank_account]).where(active: true).where(isas: {users: {bank_accounts: {account_number: bank_account_number}}}).first
  end

  def new_transaction value, ip_address
    gateway = self.gateway
    case gateway
    when PayuGateway
      @transaction = PayuTransaction.create({payment_method: 'WEBCHECKOUT', value: value, billing_document_id: self.id, status: "started",ip_address: ip_address, payu_gateway_id: gateway.id})
    when MercadoPagoGateway
      @transaction = MercadoPagoTransaction.create({payment_method: 'WEBCHECKOUT', value: value, billing_document_id: self.id, status: "started",ip_address: ip_address, payu_gateway_id: gateway.id})
    when WompiGateway
      @transaction = WompiTransaction.create({payment_method: 'WEBCHECKOUT', value: value, billing_document_id: self.id, status: "started",ip_address: ip_address, payu_gateway_id: gateway.id})
    else
      @transaction = nil
    end

    return @transaction
  end

  def user_id
    self.isa.user_id
  end

  def touch_status
    # Just to allow the status to update with touch
    self.save
  end

  def covid_config
    self.fund.covid_config
  end

  def update_document_status
    applied_value = self.applied_value_function
    
    if applied_value > 0 &&  applied_value < self.value.to_f
      self.status = 'partial_payment'
    elsif !self.due_to_date.nil? && self.pending_value != 0 && self.due_to_date < Time.now.to_date && self.status != 'arrears' && self.pending_value != 0
      self.status = 'arrears'
    elsif self.applied_value.to_f == 0 && !self.due_to_date.nil? && self.due_to_date >= Time.now.to_date && self.payment.where.not(resource_type: "PaymentAgreement").sum(:value) == 0 
      self.status = 'pending'
    end

    if self.value && self.value >= 0 && self.value.to_f <= applied_value
      self.status = 'payed'
    end
    
    self.applied_value = applied_value
    self.value = self.matched_value
  end

  def activate_billing_document
    if self.value > 0
      self.update(visible_for_student: true, active: true)
      isa = Isa.cached_find(self.isa_id)
      user = User.cached_find(isa.user_id)
      
      if self.payment_batch.send_comunication_to_student
        CommunicationMailer.billing_document_email(user.id, user.company_id, self.id).deliver
      end
    end
  end

  def pending_value
    (self.charged_value_with_penalties - self.applied_value.to_f).floor(2)
  end

  def keep_one_document_active
    if self.active
      BillingDocument.where(isa_id: self.isa_id,active: true).where.not(id: self.id).update_all(active: false)
    end
  end

  def birthday
    I18n.transliterate(self.user.personal_information.birthday.to_s)
  end

  def address1
    I18n.transliterate(self.user.location.address1.to_s)
  end

  def address2
   I18n.transliterate(self.user.location.address2.to_s)
  end

  def city
   self.user.location.city_id.nil? ? nil : I18n.transliterate(self.user.location.city.label.to_s)
  end

  def state
    self.user.location.state_id.nil? ? nil : I18n.transliterate(self.user.location.state.label.to_s)
  end

  def country_code
    self.country.international_code
  end

  def postal_code
    self.user.location.zip_code
  end

  def mobile
    self.user.contact_info.mobile
  end

  def identification_number
    self.user.identification_number
  end


  def description
   I18n.t('billing_document.description',year: self.year, month: self.month, locale: self.user.language)
  end

  def fund
    self.isa.funding_opportunity.fund
  end

  def company
    self.isa.funding_opportunity.fund.company
  end

  def country
    self.company.country
  end

  def email
    self.user.email
  end

  def currency
    self.country.currency
  end

  def signature
    gateway = self.gateway
    data_for_signature = "#{gateway.api_key}~#{gateway.merchant_id}~#{self.id}~#{20000}~#{'COP'}"
    Digest::MD5.hexdigest(data_for_signature)
  end

  def user
    self.isa.user
  end

  def language
   self.user.language
  end

  def gateway
    self.isa.funding_opportunity.fund.payment_gateway
  end

  def can_pay_with_cash_wompi?
    self.pending_value >= 140_000
  end

  def can_pay_with_mercadopago?
    self.pending_value < 140_000
  end

  def set_reference_date
    if !self.year.nil? && !self.month.nil? && self.reference_date != "#{self.year}-#{self.month}-1".to_date
      self.update(reference_date: "#{self.year}-#{self.month}-1".to_date)
    end
  end

  def payment_matches
    PaymentMatch.where(billing_document_detail_id: self.billing_document_detail.ids)
  end

  def charged_value
    self.billing_document_detail.map{|detail| detail.value}.inject(:+)
  end

  def charged_penalties
    self.billing_document_detail.map{|detail| detail.penalty(self.reference_date)}.inject(:+)
  end

  def charged_value_with_penalties
   self.charged_value.to_f + self.charged_penalties.to_f
  end

  def applied_value_function
    self.payment_match.sum(:value) + self.applied_to_penalties
  end

  def applied_to_penalties
    penalties = BillingDocumentDetail.where(billing_document_detail_id: self.billing_document_detail.ids).where('reference_date <= ?',self.reference_date)
    PaymentMatch.where(target_record_type: 'BillingDocumentDetail',target_record_id: penalties.ids).sum(:value)
    #    penalties = BillingDocumentDetail.where(billing_document_detail_id: self.billing_document_detail.ids).where('reference_date <= ?',self.reference_date).sum(:applied_value)
  end

  def matched_value
   self.billing_document_detail.sum(:value)
  end

  def pending_for_payment_value
   self.value - self.applied_value unless  self.applied_value.nil? || self.value.nil?
  end

  def billing_document_name
    self.id
  end

  def username
    self.isa.user.name
  end

  def billing_document_detail_case
    self.billing_document_detail.first.detail_case unless self.billing_document_detail.first.nil?
  end

  def detail_case
    self.billing_document_detail.first.detail_case unless  self.billing_document_detail.first.nil?
  end

  def user_name
    self.isa.user.name
  end

  def fund_name
    self.isa.funding_opportunity.fund.name
  end
end
