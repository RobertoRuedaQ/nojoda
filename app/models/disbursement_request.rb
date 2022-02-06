class DisbursementRequest < ApplicationRecord
      
      resourcify
      audited
  belongs_to :application

    has_one_attached :tuition_support
    has_one_attached :student_payment_to_institution_support
    has_one_attached :student_payment_to_lumni_support
    has_many :disbursement_match, dependent: :destroy
    has_many :disbursement_payment, dependent: :destroy
    has_many :payment_match,->{kept}, as: :target_record, dependent: :destroy

    scope :with_student_payment, ->{where.not(value_payed_by_student: nil).where('disbursement_requests.value_payed_by_student > 0')}
    scope :to_be_matched, ->{with_student_payment.where('disbursement_requests.confirmed_value < disbursement_requests.value_payed_by_student')}

    after_commit :review_payment_application

    def applied_value
      self.payment_match.sum(:value)
    end


    def review_payment_application
      if self.confirmed_value != self.applied_value
        self.update(confirmed_value: self.applied_value)
      end
    end

    def user
      self.application.user
    end

    def user_name
      self.user.name
    end


    def fund
    	self.application.resource.fund
    end

end
