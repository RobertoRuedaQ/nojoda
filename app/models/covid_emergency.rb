class CovidEmergency < ApplicationRecord
      
      resourcify
      audited
  belongs_to :billing_document
  has_one :application,->{kept},class_name: 'Application', as: :resource , dependent: :destroy
  has_one_attached :support


  after_commit :adjust_payments, except: :destroy

  def user
    self.billing_document.isa.user
  end

  def user_name
    self.user.name
  end

  def identification_number
    self.user.identification_number
  end

  def active_questionnaire
    self.application.questionnaire_review.id
  end

  def adjust_payments
    if self.done != true && !self.option.nil?
      self.update(done: true)
      case self.option
      when 'normal'
      when 'due_date'
        billing_document = self.billing_document
        billing_document.update(due_to_date: Date.civil(billing_document.year, billing_document.month, -1))
      when 'payment_agreement'
        billing_document = self.billing_document
        payment_agreement = PaymentAgreement.new(value: billing_document.pending_value, rate: 0, number_payments: 3, status: "valid", agreement_case: "normalization", start_date: "2020-08-01", billing_document_id: billing_document.id,isa_id: billing_document.isa_id)
        if payment_agreement.save
          batch = billing_document.payment_batch
          isa = billing_document.isa
          isa.generate_billing_document(batch)
        end
      when 'custom_adjustment'
      when 'no_payment'
        isa = self.billing_document.isa
        isa.set_new_status('income_status','no_payment', self.start_date, self.end_date)
        billing_document = self.billing_document
        billing_document.refresh
      end
    end
  end

  def self.active_action_by_user user_id
  	CovidEmergency.joins(billing_document: :isa).where(status: ['active','under_review']).where('covid_emergencies.start_date <= ?', Time.now.to_date).where('covid_emergencies.end_date >= ?', Time.now.to_date).where(billing_documents: {isas: {user_id: user_id}})
  end

  def self.pending_to_review user_id
  	CovidEmergency.joins(billing_document: :isa).where(status: 'under_review').where(billing_documents: {isas: {user_id: user_id}}).first
  end

  def self.pendings_to_review user_id
    CovidEmergency.joins(billing_document: :isa).where(status: 'under_review').where(billing_documents: {isas: {user_id: user_id}})
  end


  def origination
  	Origination.cached_find(113)
  end
  
end
