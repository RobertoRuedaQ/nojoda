class Payment < ApplicationRecord
      
  resourcify
  audited

  has_many :application,->{kept}, as: :resource, dependent: :destroy
  belongs_to :billing_document, optional: true
  belongs_to :disbursement, optional: true
  has_many :payment_match,->{kept}, as: :resource, dependent: :destroy
  belongs_to :resource, polymorphic: true,touch:true,optional: true
  has_one :payment_excess, dependent: :destroy
  belongs_to :payment_mass_doc, ->{joins(:payment).where(payments: {resource_type: 'PaymentMassDoc'})},class_name: 'PaymentMassDoc', foreign_key: 'resource_id',optional: true,touch: true
  belongs_to :payu_response, ->{joins(:payment).where(payments: {resource_type: 'PayuResponse'})},class_name: 'PayuResponse', foreign_key: 'resource_id',optional: true,touch: true
  belongs_to :mercado_pago_response, ->{joins(:payment).where(payments: {resource_type: 'MercadoPagoResponse'})},class_name: 'MercadoPagoResponse', foreign_key: 'resource_id',optional: true,touch: true


  has_one_attached :payment_support

  validates_uniqueness_of :resource_id  , scope: [:value, :resource_type, :billing_document_id], unless: :resource_type_nil?

  after_create :match_payments, except: :destroy
  after_commit :refresh_billing_document
  after_commit :update_student_xirr

  def refresh_billing_document
    self.billing_document.save if self.billing_document.present?
  end

  def resource_type_nil?
    self.resource_type.nil?
  end

  def update_student_xirr
    return unless self.billing_document_id.present?
    isa = self.billing_document.isa
    PerformServiceAsync.perform_in(5.minutes,'UpdateXirrService', isa.id)
  end


  def self.not_applied_payments
    Payment.where("id NOT IN (SELECT DISTINCT(resource_id) FROM payment_matches WHERE resource_type= 'Payment')")
  end

  def self.not_applied_payments
    Payment.where("id NOT IN (SELECT DISTINCT(resource_id) FROM payment_matches WHERE resource_type= 'Payment')")
  end

  def submitted_application
    self.application.find_by_status('submitted')
  end

  def active_questionnaire
    result = nil
    if !self.submitted_application.nil? 
      result = self.submitted_application.questionnaire_review.id
    end
    return result
  end

  def fix_overpayment detail
    if detail.applied_value.to_f > detail.value.to_f
      detail_difference = detail.applied_value.to_f - detail.value.to_f

      self.payment_match.where(target_record_type: "BillingDocumentDetail", target_record_id: detail.id).each do |match|
        adjust_value = [detail_difference,match.value].min
        match.update(value: (match.value - adjust_value))
        detail_difference -= adjust_value
      end
      self.match_payments
    end
  end

  def user
    self.billing_document.user unless self.billing_document.nil?
  end

  def match_payments options={}

    if self.payment_match.sum(:value) != self.value && !(self.payment_mass_doc.present? && self.payment_mass_doc.disbursement_request.present?)

      if options[:billing_document_id].nil?
        billing_document = self.billing_document
      else
        billing_document = BillingDocument.find(options[:billing_document_id])
      end
      detail_ids = billing_document.billing_document_detail.ids
      # The original order is :desc. It won't sort :asc directly. This structure allows to apply the old documents first.
      details = BillingDocumentDetail.where(id: detail_ids).order(reference_date: :asc)
      available_amount = self.not_applied

      @self_agreement_id = self.resource_id if self.resource_type == 'PaymentAgreement'

      repayments = details.where(detail_case: "repayment")
      payment_agreement = details.where(detail_case: "payment_agreement").where.not(payment_agreement_id: @self_agreement_id).or(
        details.where(detail_case: "payment_agreement").where(payment_agreement_id: nil))
      nominal_payment = details.where(detail_case: "nominal_payment")
      migrated_penalties = details.where(detail_case: "penalty")
      penalty = BillingDocumentDetail.where(billing_document_detail_id: details.ids)


      repayments.each do |detail|
          available_amount = available_amount - self.apply_payment(detail,available_amount)
      end

      payment_agreement.each do |detail|
          available_amount = available_amount - self.apply_payment(detail,available_amount)
      end

      nominal_payment.each do |detail|
          available_amount = available_amount - self.apply_payment(detail,available_amount)
      end

      penalty.each do |detail|
          available_amount = available_amount - self.apply_payment(detail,available_amount)
      end

      migrated_penalties.each do |detail|
          available_amount = available_amount - self.apply_payment(detail,available_amount)
      end

      begin
        if available_amount > 0
          payment_excess = self.payment_excess
          if payment_excess.nil? && self.resource_type != 'PaymentAgreement'
            payment_excess = PaymentExcess.create(user_id: billing_document.isa.user_id, payment_id: self.id, value: available_amount, status: 'active')
          else
            payment_excess.update(value: available_amount, status: 'active')
          end
        elsif !self.payment_excess.nil?
          self.payment_excess.update(value: available_amount, status: 'inactive')
        end
      rescue StandardError => e
        puts e
      end
    elsif self.payment_mass_doc.present? && self.payment_mass_doc.disbursement_request.present?
      begin
        if self.value > 0
          PaymentMatch.find_or_create_by(resource_type: "Payment", resource_id: self.id, value: self.value, target_record_type: "DisbursementRequest", target_record_id: self.payment_mass_doc.disbursement_request_id)
        end
      rescue StandardError => e
        puts e
      end
    end
  end

  def apply_payment detail,available_amount
    begin
      to_apply = [[detail.pending_value,available_amount].min,0].max
      if to_apply > 0
        PaymentMatch.create({resource_type: 'Payment',resource_id: self.id,value: to_apply, target_record_type: 'BillingDocumentDetail',target_record_id: detail.id })
      end
      return to_apply
    rescue StandardError => e
      puts e
    end
  end

  def not_applied
    self.value.to_f - self.payment_match.sum(:value).to_f
  end

  # Elements to get applications working (start)

  def origination
    origination = self.billing_document.fund.payment_origination.manual_payment_origination
    return origination
  end
# Elements to get applications working (End)

  def payment_method_info
    payment_mass? && self.payment_mass_detail ? self.payment_mass_detail.status : self.payment_method
  end

  def inconsistency
    payment_mass? && self.payment_mass_doc ? self.payment_mass_doc.payment_mass_detail.problem_case : does_not_apply
  end

  def account_case
    payment_mass? && self.payment_mass_doc ? self.payment_mass_doc.payment_mass_detail.account_case : does_not_apply
  end

  def bank_number
    payment_mass? && self.payment_mass_doc ? self.payment_mass_doc.payment_mass_detail.bank_number : does_not_apply
  end

  def description
    payment_mass? && self.payment_mass_doc  ? self.payment_mass_doc.payment_mass_detail.description : does_not_apply
  end

  def billing_document_info
    self.billing_document.id unless self.billing_document.nil?
  end


  def payment_mass?
    self.payment_method == 'payment_mass'
  end

  def fund
    self.billing_document.fund unless self.billing_document.nil? 
  end

  def office
    payment_mass? && self.payment_mass_doc ? self.payment_mass_doc.payment_mass_detail.office : does_not_apply
  end

  def ref_1
    payment_mass? && self.payment_mass_doc ? self.payment_mass_doc.payment_mass_detail.ref_1 : does_not_apply
  end

  def ref_2
    payment_mass? && self.payment_mass_doc ? self.payment_mass_doc.payment_mass_detail.ref_2 : does_not_apply
  end

  def city_of_payment
    payment_mass? && self.payment_mass_doc ? self.payment_mass_doc.payment_mass_detail.city : does_not_apply
  end

  def account_case
    payment_mass? && self.payment_mass_doc ? self.payment_mass_doc.payment_mass_detail.account_case : does_not_apply
  end

  def does_not_apply
    'No aplica'
  end

  def fund_name
    self.billing_document.fund.name unless self.billing_document.nil? 
  end

  def user_identification_number
    self.billing_document.user.identification_number unless self.user.nil?
  end
end
