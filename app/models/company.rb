class Company < ApplicationRecord
    resourcify
  audited
	
  belongs_to :income_origination, class_name: 'Origination', foreign_key: 'income_origination_id'
  belongs_to :origination_funded_major, class_name: 'Origination', foreign_key: 'origination_funded_major_id'
  belongs_to :user, optional: true
  belongs_to :company, optional: true
  belongs_to :country
  belongs_to :credit_check_disclosure, class_name: 'LegalDocument', foreign_key: 'credit_check_disclosure_id', optional: true
  has_many :legal_document,dependent: :destroy
  has_many :fund, dependent: :destroy
  has_one_attached :main_logo, dependent: :destroy
  has_one_attached :login_logo, dependent: :destroy
  has_one_attached :signup_logo, dependent: :destroy
  has_many :student_route, -> { order(:id) }, as: :resource , dependent: :destroy
  has_many :questionnaire, dependent: :destroy
  has_one :contact_info, as: :resource , dependent: :destroy
  has_one :location, as: :resource , dependent: :destroy
  has_one :disbursement_origination, dependent: :destroy
 

  has_many :students,->{where(type_of_account: "student")}, class_name: 'User', foreign_key: 'company_id'

  after_commit :flush_companies_cache
  after_create :create_company_routes
  after_create :setup_company_init

  def restricted?
    self.status == 'inactive'	
  end

  def self.contracts_to_approve
    contract_types = ['isa_contract_adult','isa_contract_young','amendment_adult','amendment_young']
    companies_ids = self.ids
    target_applications = Application.includes(:user, :funding_opportunity).joins(:legal_match,[legal_match: :legal_document])
        .where(status: ['active','submitted'])
        .where(legal_matches: {legal_documents:{document_type: contract_types }})
        .where(legal_matches: {status: ['attached','active']}).or(
          Application.includes(:user, :funding_opportunity).joins(:legal_match,[legal_match: :legal_document])
          .where(status: ['active','submitted'])
          .where(legal_matches: {legal_documents:{document_type: contract_types }})
          .where(legal_matches: {pending_for_scan: true,status: ['pending_for_scan','active']})
          )
  end

  def setup_company_init
    ContactInfo.create({resource_type: 'Company',resource_id: self.id})
    Location.create({resource_type: 'Company',resource_id: self.id})
    DisbursementOrigination.create({company_id: self.id,max_request_by_disbursement: 1,
                                    percentage_previous_tuition: 0,percentage_next_tuition: 0,
                                    percentage_previous_living_expenses: 0,percentage_next_living_expenses: 0
                                  })
  end

  def cached_currency
    Rails.cache.fetch(['company_cached_currency',self.country_id]){self.country.currency}
  end

  def cached_precision
    Rails.cache.fetch(['cached_company_precision',self.country_id]){self.country.round_up_to}
  end

  def active_funding_opportunities
    FundingOpportunity.active_funding_opportunities(self.my_companies.ids)
  end

  def all_funding_opportunities
    FundingOpportunity.where(fund_id: self.fund.ids).kept
  end


  def get_student_profile_id action
    self.student_route.find_by_scenario(action).team_profile_id
  end

  def create_company_routes
    target_actions = ['create_account','confirm_email','student_activation','start_payments','end_payments']
    target_actions.each do |action|
      target_profile = TeamProfile.find_by_action(action)
      StudentRoute.create({resource_id: self.id, resource_type: 'Company',scenario: action, team_profile_id: target_profile.id})
    end
  end

  def cached_company_staff 
    Rails.cache.fetch(['cached_company_staff',self.id]){company_staff}
  end
  def company_staff 
    User.where(company_id: self.holding_companies, type_of_account: 'staff',status: 'active')
  end



  def self.cached_current_company(target_url)
  	Rails.cache.fetch([name,target_url]) {find_current_company(target_url)}
  end

  def self.find_current_company target_url
    tempCompany = Company.kept.find_by_url(target_url)
    if tempCompany.nil?
      tempCompany = Company.kept.find_by_url('localhost:3000')
    end
    return tempCompany
  end

  def access_companies
    tempAccessCompanies = Company.where(company_id: self.id)

    accessCompanies = [self.id] + tempAccessCompanies.map{|h| h.id}

    additional_companies = Company.where(company_id: accessCompanies).map{|a| a.id} - accessCompanies

    while additional_companies.length > 0
      accessCompanies += additional_companies
      additional_companies = Company.where(company_id: accessCompanies).map{|a| a.id} - accessCompanies
    end

    return accessCompanies

  end

  def holding_companies
    startPoint = self
    mainCompany = nil

    while mainCompany == nil
      if startPoint.company_id.nil?
        mainCompany = startPoint.id
      else
        startPoint = startPoint.company
      end
    end

    return startPoint.access_companies

  end

  def holding
    Company.where(id: self.holding_companies)
  end

  def cached_holding
    Rails.cache.fetch([self.id, 'holding']){holding}
  end

  def cached_holding_companies
    Rails.cache.fetch([self.id, 'holding_companies']){holding_companies}
  end

  def my_companies
    Company.where(id: self.access_companies)
  end

  def cached_my_companies
    Rails.cache.fetch([self.id,'cached_my_companies']){my_companies}
  end

  def cached_access_companies
    Rails.cache.fetch([self.id,'access_companies']){access_companies}
  end

  def flush_companies_cache
    Rails.cache.delete([self.id, 'holding'])
    Rails.cache.delete([self.id,'access_companies'])
    Rails.cache.delete([self.id, 'holding_companies'])
    Rails.cache.delete([self.id,'cached_my_companies'])
    Rails.cache.clear
  end


end
