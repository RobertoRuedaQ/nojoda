class StudentFinancialInformation < ApplicationRecord
      
  resourcify
  audited
  belongs_to :user, class_name: 'Student',foreign_key: 'user_id', touch: true
  has_many :student_expenses

  has_one_attached :tax_authority_document
  has_one_attached :payroll_deduction_authorization

  def origination
    self.user.active_isa.first.funding_opportunity.fund.student_financial_information_origination
  end

end
