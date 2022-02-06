class Fund < ApplicationRecord
    resourcify
  audited

  belongs_to :fund, optional: true
  belongs_to :company
  belongs_to :cancellation_origination,class_name: 'Origination',foreign_key: 'cancellation_origination_id', optional: true
  belongs_to :conciliation_origination,class_name: 'Origination',foreign_key: 'conciliation_origination_id', optional: true
  belongs_to :graduation_cancellation_origination,class_name: 'Origination',foreign_key: 'graduation_cancellation_origination_id', optional: true
  belongs_to :student_financial_information_origination,class_name: 'Origination',foreign_key: 'student_financial_information_origination_id', optional: true
  belongs_to :student_location_origination,class_name: 'Origination',foreign_key: 'student_location_origination_id', optional: true
  belongs_to :student_personal_information_origination,class_name: 'Origination',foreign_key: 'student_personal_information_origination_id', optional: true
  belongs_to :student_contact_information_origination,class_name: 'Origination',foreign_key: 'student_contact_information_origination_id', optional: true
  belongs_to :user_data_origination,class_name: 'Origination',foreign_key: 'user_data_origination_id', optional: true
  belongs_to :academic_stop_origination,class_name: 'Origination',foreign_key: 'academic_stop_origination_id', optional: true
  belongs_to :fund_withdrawal_origination,class_name: 'Origination',foreign_key: 'fund_withdrawal_origination_id', optional: true
  belongs_to :bank_account_origination,class_name: 'Origination',foreign_key: 'bank_account_origination_id', optional: true
  belongs_to :black_rock_origination,class_name: 'Origination',foreign_key: 'black_rock_origination_id', optional: true
  belongs_to :wompi_gateway, optional: true
  
  has_many :funding_opportunities,->{kept},dependent: :destroy
  has_many :subfund,->{kept}, class_name: 'Fund', foreign_key: 'fund_id', dependent: :destroy
  belongs_to :payment_gateway, polymorphic: true
  has_one :covid_config, dependent: :destroy
  has_one :payment_origination, dependent: :destroy
  has_many :bank_account,->{kept}, as: :resource , dependent: :destroy
  has_many :cancellation_config, dependent: :destroy
  has_many :valuation_histories, dependent: :destroy

  after_create :create_payment_origination
  after_update :update_user_rate_cap

  def create_payment_origination
    PaymentOrigination.create({fund_id: self.id})
  end


  def parent_fund
  	result = self.fund.name if !self.fund.nil?
  	return result
  end


  def total_funding_options valuation_history_id
    target_funding_options = self.total_funding_options_initial.ids - ValuationHistory.find(valuation_history_id).modeling_flows.pluck(:funding_option_id)
    FundingOption.where(id: target_funding_options)
  end

  def total_funding_options_initial
    FundingOption.joins(isa: :funding_opportunity).where(isas: {funding_opportunities: {fund_id: self.total_fund_ids}})
  end


  def total_fund_ids
    subfund = []
    new_subfund = [self.id]
    while new_subfund.count > 0
      temp_subfund = Fund.where(fund_id: new_subfund)
      subfund += new_subfund
      new_subfund = temp_subfund.ids - subfund
    end
    subfund
  end


  private

  def update_user_rate_cap
    FundingOptionConfig.joins(funding_option: [isa: :funding_opportunity]).where('funding_opportunities.fund_id = ?',self.id).where(name: 'rate_cap').where.not(value: 25.0).update_all(value: self.cap_rate)
  end
end
