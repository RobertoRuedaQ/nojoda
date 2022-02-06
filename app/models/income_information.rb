class IncomeInformation < ApplicationRecord
  
  include FullTextSearchableConcern

  resourcify
  audited
  belongs_to :city, class_name: 'Geography', foreign_key: 'city_id', optional: true
  belongs_to :state, class_name: 'Geography', foreign_key: 'state_id', optional: true
  belongs_to :country, class_name: 'Geography', foreign_key: 'country_id', optional: true
  belongs_to :user, touch: true
  belongs_to :parent, class_name: 'IncomeInformation', foreign_key: 'parent_id', optional: true
  has_many :raw_applications, class_name: 'Application', as: :resource, dependent: :destroy
  has_many :income_variable_income, dependent: :destroy

  has_many :past_applications,->{where.not(status: ['active','submitted'])} ,as: :resource ,class_name: 'Application', dependent: :destroy

  has_one :application,->{where(status: ['active','submitted'])} , as: :resource , dependent: :destroy

	has_many_attached :income_certificate


  scope :income_not_final_date, -> {where(status: 'active',active_check: true, end_date: nil)}
  scope :income_not_valid_date, -> {where(status: 'active',active_check: true).where.not('end_date >= ?', Time.now.to_date)}
  scope :income_valid_date, -> {where(status: 'active',active_check: true).where('end_date >= ?', Time.now.to_date)}

  before_save :set_active_check
  before_save :set_operation_status
  before_save :set_exchange_rates

  pg_search_scope :full_text_search, 
                  against: [
                    :operations_status, 
                    :fix_income,
                    :variable_income,
                    :id,
                    :company_name,
                    :position,
                    :start_date,
                    :end_date
                  ],
                  associated_against: {
                    user: [
                      :searcher_name,
                      :identification_number
                    ]
                  },
                  ignoring: :accents,
                  using: {
                    tsearch: { prefix: true }
                  }

  def full_name
    self.company_name.to_s  + '(' + self.start_date.to_s + ' - ' + self.end_date.to_s + ')'
  end

  def set_operation_status
    if self.status == 'rejected'
      self.operations_status = 'rejected'
    elsif self.end_date.present? && self.end_date < Time.now
      self.operations_status = 'finished'
    elsif self.end_date.nil? || self.end_date >= Time.now
      self.operations_status = 'active'
    end
  end

  def self.update_exchange_rates currency, country
    rates = currency == country.currency ? 1 : CurrenyHistory.get_last_rate(currency, country.currency).value

    self.joins(user: [company: :country]).where(currency: currency, users: { companies: { country_id: country.id}}).update_all(exchange_rates: rates)
  end


  def set_exchange_rates

    if company_country.present? && company_country.currency != self.currency && self.currency.present?
      self.exchange_rates =  CurrenyHistory.get_last_rate(self.currency, self.company_country.currency).value
    else
      self.exchange_rates = 1
    end
  end

  def set_active_check
    self.active_check = true
  end


  def total_income
  	self.fix_income.to_f + self.variable_income.to_f
  end

  def active_questionnaire
    self.application.questionnaire_review.id
  end


  def origination
    self.user.company.income_origination
  end

  def company_country
    self.user.company.country
  end

  def exchange_rate
    company_currency = self.company_country.currency
    if self.currency == company_currency
      result = 1
    else
      result = target_exchage_rate(Time.now.last_month.end_of_month.to_date,company_currency)
    end
  end


  def income_in_local_currency
    self.total_income * self.exchange_rates
  end

  def target_exchage_rate target_date, target_currency
    CurrenyHistory.find_by(date: target_date, currency_base: self.currency, currency_target: target_currency).value
  end


  def can_be_edited?
    return true if self.end_date.nil?

    Time.zone.now < self.end_date
  end


  def country_name
    if !self.country.nil?
      @response = self.country.label
    end
    return @response
  end

  def state_name
    if !self.state.nil?
      @response = self.state.label
    end
    return @response
  end

  def city_name
    if !self.city.nil?
      @response = self.city.label
    end
    return @response
  end



end



