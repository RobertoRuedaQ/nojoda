class User < ApplicationRecord
  include FullTextSearchableConcern
  include LumniOrigination
  require "mini_magick"

  resourcify
  audited except: [:encrypted_password,:reset_password_token,:reset_password_sent_at,:remember_created_at,:sign_in_count,:current_sign_in_at,
    :last_sign_in_at,:current_sign_in_ip,:last_sign_in_ip,:confirmation_token,:confirmed_at,:confirmation_sent_at,:unconfirmed_email,:failed_attempts,
    :unlock_token,:locked_at,:session_token]

  acts_as_approval_user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  has_one_attached :avatar
  has_one_attached :credit_check_autoreport
  has_one_attached :curriculum_vitae
  has_many :collection, dependent: :destroy
  has_many :active_collection,->{where(status: 'active')}, class_name: 'Collection', foreign_key: 'user_id'

  has_one :complementary_activity, dependent: :destroy
  has_many :activities_detail, dependent: :destroy



  has_many :social_work, dependent: :destroy

  has_one :info_terpel,dependent: :destroy
  has_one :contact_info, as: :resource , dependent: :destroy
  has_one :location, as: :resource , dependent: :destroy
  has_one :personal_information, dependent: :destroy
  has_many :application,->{kept}, dependent: :destroy
  has_many :signer, :class_name => "FundingOpportunity", foreign_key: "signer_id"
  has_many :approval_match, dependent: :destroy
  has_many :projects, :class_name => 'Project', foreign_key: 'owner_id', dependent: :destroy
  has_many :supervising, class_name: 'TeamSupervisor',foreign_key: 'supervisor_id', dependent: :destroy
  has_many :reporting_to, class_name: 'TeamSupervisor',foreign_key: 'team_member_id', dependent: :destroy
  has_many :supporting_team,->{where.not(support_role_id: nil).kept}, class_name: 'TeamSupervisor',foreign_key: 'team_member_id', dependent: :destroy
  has_many :communication_user,->(){order(created_at: :desc)}, dependent: :destroy
  has_many :created_tasks, class_name: 'ProjectTask', foreign_key: 'created_by_id', dependent: :destroy
  has_many :asigned_tasks, class_name: 'ProjectTask', foreign_key: 'responsable_id', dependent: :destroy
  has_many :legal_match, dependent: :destroy
  has_many :user_questionnaire,->{joins(origination_section: [origination_module: :origination]).where('originations.discarded_at IS NULL AND origination_modules.discarded_at IS NULL AND origination_sections.discarded_at IS NULL').distinct}, dependent: :destroy
  has_many :leading_business, class_name: 'BizdevBusiness', foreign_key: 'leader_id',dependent: :destroy
  has_many :coleading_business, class_name: 'BizdevBusiness', foreign_key: 'coleader_id', dependent: :destroy
  has_many :notification,->(){kept.order(created_at: :desc)}, dependent: :destroy
  has_many :funding_token,->{kept}, dependent: :destroy
  has_one :personal_covid_emergency, dependent: :destroy


  has_many :active_isa,->{where(status: 'active').kept}, class_name: 'Isa'

  has_many :non_graduated_programs,->{where(graduation_date: nil)} , through: :active_isa, source: :student_academic_information

  has_many :modeling_variable, dependent: :destroy

  has_one :student_financial_information,dependent: :destroy
  has_many :student_academic_information,-> (){order(:created_at)},dependent: :destroy

  has_many :user_aggregation,dependent: :destroy

  has_many :child,-> {kept},dependent: :destroy
  has_one :health,dependent: :destroy
  has_one :bff_question,dependent: :destroy
  has_many :reference,->{order(:row)},dependent: :destroy
  has_many :income_information,->{where.not(status: 'under_review').or(where(status: nil)).order(start_date: :desc).kept},dependent: :destroy
  has_many :active_income_information,->{income_not_final_date.or(income_valid_date).order(:start_date).kept},class_name: 'IncomeInformation', foreign_key: 'user_id',dependent: :destroy
  has_many :incomplete_income_information,->{order(:start_date).kept},class_name: 'IncomeInformation', foreign_key: 'user_id',dependent: :destroy
  has_many :bank_account, ->{ where(active: true) }, as: :resource , dependent: :destroy
  has_many :all_bank_accounts,as: :resource, class_name: 'BankAccount'
  has_one :sociodemographic,dependent: :destroy
  has_many :isa,->{kept},dependent: :destroy
  has_many :student_config,dependent: :destroy
  has_many :student_debt,->{kept}, dependent: :destroy
  has_many :payment_excess, dependent: :destroy

  has_many :funding_opportunity_applications, ->{where(resource_type: 'FundingOpportunity')}, class_name: 'Application', foreign_key: 'user_id'
  has_many :funding_opportunity_application_approved, ->{where(resource_type: 'FundingOpportunity', status: "approved")}, class_name: 'Application', foreign_key: 'user_id'

  has_many :funded_programs, ->{where(information_case: 'to_be_funded')},class_name: 'StudentAcademicInformation',foreign_key: 'user_id'

  has_one :legacy_status, class_name: 'LegacyStatus', foreign_key: 'external_id', primary_key: 'external_id'
  has_many :conciliation_information, through: :isa, source: :conciliation_information

  has_one :ongoing_application, ->{where(status: ["submitted", "approved", "active"],resource_type: ['FundingOpportunity', 'Isa']).order(created_at: :desc)}, class_name: 'Application', foreign_key: 'user_id'
  has_many :valuation_histories, dependent: :destroy
  has_one :black_rock_data,dependent: :destroy

  belongs_to :company
  belongs_to :team_profile  
  
  has_one :user_questionnaire_committee_pending,->{joins(:questionnaire).where(questionnaires:{category: 'review'} ).where(questionnaires: {id: 149740})},class_name: 'UserQuestionnaire', foreign_key: 'user_id'
  
  scope :user_questionnaire_committee,->{joins(user_questionnaire: :questionnaire).where(questionnaires:{category: 'review'} ).where(questionnaires: {id: 149740})}
  scope :to_application_committee, ->(funding_opportunity_id){joins(:user_questionnaire,[user_questionnaire: :questionnaire], [user_questionnaire: :application]).where(user_questionnaires: {status: ['submitted','ongoing']}).where(user_questionnaires: {questionnaires: {category: 'review'}}).where(user_questionnaires: {applications: {resource_id: funding_opportunity_id,resource_type: 'FundingOpportunity'}})}
  
  scope :for_student_edit, ->{full_disbursements.full_collection.full_country_info.full_project}
  scope :getting_billing_document, ->{includes(active_isa: [billing_document: :billing_document_detail])}
  scope :full_collection, ->{getting_billing_document.includes({active_isa: [{billing_document: [{payment_agreement: :payment,billing_document_match: [{billing_document_detail: [{penalties: [{payment_match: :payment}],payment_match: :payment}]}]}]}]})}
  scope :full_country_info, -> {includes({active_isa: [{funding_option: [{application: [{funding_opportunity_from_resource: [{fund: [{company: :country}]}]}]}]}]})}
  scope :full_disbursements, ->{includes({active_isa: [{funding_option: [{disbursement: :disbursement_match}]}]})}
  scope :full_project, ->{includes({projects:[{project_card: :project_task}]})}

  scope :from_company, ->(company_id){where(company_id: company_id)}
  scope :full_student, ->{includes(:contact_info, :location, :student_academic_information, [student_academic_information: :school_info], [student_academic_information: :university_info], :reporting_to, :legal_match, :user_questionnaire,:child,:health,:reference,:income_information,:bank_account,:sociodemographic,:isa,:student_debt)}
  scope :my_students, ->(user_id){joins(:reporting_to).where(team_supervisors: {supervisor_id: user_id},type_of_account: 'student')}
  scope :active_applicats, ->{joins(:application).where(applications: {status: ["submitted", "approved", "active"],resource_type: 'FundingOpportunity'})}
  scope :active_students, ->{joins(:isa).where(isas: {status: 'active'})}
  scope :by_funding_opportunity, ->(funding_opportunity_ids){joins(:personal_information,isa: [funding_option: :application]).where(isas: {status: 'active'}).where(isas: {funding_options: {applications: {resource_type: 'FundingOpportunity',resource_id: funding_opportunity_ids}}})}
  scope :by_isa_general_status, ->(status){joins(:isa).where(isas: {stored_general_status: status})}



  scope :scope_identification_number, ->(identification_number){joins(:personal_information).where('personal_informations.identification_number LIKE ?',"%#{identification_number}%")}
  scope :scope_bank_account, ->(bank_account){joins(:bank_account).where('bank_accounts.account_number LIKE ?',"%#{bank_account}%")}
  scope :scope_email, ->(email){where('email LIKE ?',"%#{email}%")}


 before_save :set_searcher_name

   before_create :set_locale
  before_create :skip_confirmation
  
  after_create :create_contact_info
  after_create :create_location
  after_create :create_personal_information
  after_create :create_complementary_activity

  after_create :startProject

  after_update :project_name

 after_commit :flush_user

  pg_search_scope :full_text_search, 
                  against: [
                    :email, 
                    :identification_number,
                    :searcher_name
                  ],
                  associated_against: {
                    contact_info: [
                      :mobile,
                      :phone
                    ]
                  },
                  ignoring: :accents,
                  using: {
                    tsearch: { prefix: true }
                  }

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end
  
  def origination
    self.funds.first.user_data_origination
  end

  def modeling_variables_hash
      self.modeling_variable.includes(research_model_info: :research_variable).map{|variable| variable.modeling_hash}
  end

  def set_searcher_name
    searcher_name = I18n.transliterate(self.name.to_s.downcase)
    if self.searcher_name != searcher_name
      self.searcher_name = searcher_name
    end
  end

  def full_name
    "#{self.first_name} #{self.middle_name} #{self.last_name}"
  end

  def clean_words word
    I18n.transliterate(word.to_s.gsub( ' ', '').downcase)
  end

  def funding_opportunities
    Rails.cache.fetch(['user_funding_opportunities',self.id]){self.isa.where(status: 'active').map{|isa| isa.funding_opportunity}}
  end

  def funding_opportunities_names
    self.funding_opportunities.pluck(:name).join(',')
  end

  def funds
    if self.isa.any?
      Rails.cache.fetch(['user_funds',self.id]){self.isa.where(status: 'active').map{|isa| isa.funding_opportunity.fund}}
    else
      self.application.select{|a| a.application_case == 'origination'}.map{|a|a.resource.fund }
    end
  end

  def funds_names
    self.funds.pluck(:name).uniq.join(',')
  end

  def self.searcher_by_name value
    words = value.split(' ') - ['']
    words = words.select { |w| !w.include?('@')}
    words = words.select { |w|  w.size > 2  }
    words = words.select { |w| w.to_i == 0}
    words = words.map{ |w| I18n.transliterate(w.to_s.gsub( ' ', '').downcase)}
    if words.count > 0
      conditional1 =  Array.new(words.count,'searcher_name LIKE ?').join(' AND ')
      conditional2 =  words.map{|w| "'%#{w}%'"}.join(',')
      @result = eval("self.where('#{conditional1}',#{conditional2})")
    end
    return @result
  end

  def self.searcher value
    by_names = self.searcher_by_name(value)
    if by_names.nil?
      target_ids = []
    else
      target_ids = by_names.ids
    end
    target_ids += self.scope_identification_number(value).ids
    target_ids += self.scope_bank_account(value).ids
    target_ids += self.scope_email(value).ids
    self.where(id: target_ids.uniq).limit(100)
  end

  def has_complementary_activities?
    self.complementary_activity.workshop || self.complementary_activity.mentorship
  end

  def country_external_code
    case self.country_code
      when 'CO'
        1
      when 'MX'
        2
      when 'CL'
        3
      when 'US'
        4
      when 'PE'
        5
      else
        -1
    end
  end

  def country_code
    self.company.country.international_code
  end

  def contact_phone
    [self.contact_info.mobile, self.contact_info.phone, self.contact_info.other_phone].compact.first
  end

  def address
    [self.location.address1, self.location.address2].join(', ')
  end

  def covid_cases_to_review
    CovidEmergency.pendings_to_review(self.id)
  end

  def payments_to_review
    Payment.joins(:application,billing_document: :isa).where(applications: {status: 'submitted'}).where(billing_documents: {isas: {user_id: self.id}})
  end

  def self.include_funding_opportunity
    self.joins(active_isa: [funding_option: [application: :funding_opportunity_from_resource]])
  end

  def funding_opportunity_name
    result = nil
    isa = self.isa.first
    if !isa.nil?
      result = isa.funding_opportunity.name
    end
    return result
  end


  def self.where_email email_input
    User.joins(:contact_info).where(email: email_input).or( User.joins(:contact_info).where(contact_infos: {secondary_email: email_input}))
  end

  def self.find_by_email email_input
    User.where_email(email_input).first
  end

  def active_applicant?
    !User.active_applicats.find(self.id).nil?
  end

  def active_student?
    begin
      !User.active_students.find(self.id).nil?
    rescue Exception => e
      false     
    end
  end

  def support_person support_role_id
    person = self.supporting_team.find_by(support_role_id: support_role_id)
    if person.nil?
      person = self.supporting_team.find_by(support_role_id: 1)
    end
    return person
  end


  def cached_company_url
    Rails.cache.fetch(['user_company_url_cached',self.id],expires_in: 8.hours){company_url}
  end

  def company_url
    self.company.url
  end

  def income_under_review
    self.incomplete_income_information.joins(:application,[application: :user_questionnaire]).where(applications: {status: 'submitted'}).distinct
  end

  def income_active_application
    self.incomplete_income_information.joins(:application).where(applications: {status: 'active'})
  end

  def staff?
    self.type_of_account == 'staff'
  end

  def with_isa?
    self.isa.where(status: 'active').count > 0
  end

  def adult? country
    country.legal_age.to_i <= self.age.to_i
  end

  def pending_interview?
    self.pending_interviews.count > 0
  end

  def pending_interviews
    self.user_questionnaire.includes(:questionnaire).where( 'user_questionnaires.status IN (?)',["active",'ongoing']).where(questionnaires: {category: 'interview'}).distinct
  end

  def with_active_contract?
    self.active_contracts.count > 0
  end

  def active_contracts
    self.legal_match.joins(:legal_document).where(legal_documents: {document_type: ["isa_contract_young", "isa_contract_adult", "amendment_young","amendment_adult"]}).where(status: 'active')
  end

  def eligibility_criteria_step
    !self.confirmed_at.nil? && self.active_application.nil? && self.submitted_application.nil?
  end

  def filling_application_step
    !self.active_application.nil? && self.submitted_application.nil?
  end

  def credit_check_step current_company, element_check
    !self.submitted_application.nil? && !current_company.credit_check_disclosure_id.nil? && !self.current_application.document_signed?(current_company.credit_check_disclosure_id) && element_check
  end

  def contract_step current_company, target_contract, target_promissory_note=nil
    #Include validation in case the funding opportunity have promissory note it should have both contract signed.
    if target_promissory_note.present?
      self.current_application.present? && (self.current_application.document_signed?(current_company.credit_check_disclosure_id) || current_company.credit_check_disclosure_id.nil?) && (!self.current_application.document_signed?(target_contract) && !self.current_application.document_signed?(target_promissory_note))
    else
      self.current_application.present? && (self.current_application.document_signed?(current_company.credit_check_disclosure_id) || current_company.credit_check_disclosure_id.nil?) && !self.current_application.document_signed?(target_contract)
    end

  end

  def flush_user
    Rails.cache.delete(['User',self.id])
    Rails.cache.delete(['Student',self.id])
    Rails.cache.delete(['Applicant',self.id])
    Rails.cache.delete(['Profile',self.id])
    Rails.cache.delete(['super_user_tag',self.id])
    self.active_isa.first.save if self.active_isa.first
  end

  def super_user?
    Rails.cache.fetch(['super_user_tag',self.id]){team_profile.name == "Super User"}
  end

  def test_user?
    self.email.include?('jcastillole')
  end

  def funded_academic_information
    self.student_academic_information.where(information_case: 'to_be_funded').last
  end

  def last_school
    self.student_academic_information.where(information_case: 'school').last
  end

  def school_average_score
    result = nil
    temp_school = self.last_school
    if !temp_school.nil? && !temp_school.school_info.nil?
      result = temp_school.school_info.average_score
    end
    return result
  end

  def residence_v_institution
    residence = self.location.city_id
    institution = self.funded_institution.location.city_id
    result = nil
    if !residence.nil? && !institution.nil?
      result = (residence == institution)
    end
    return result
  end

  def total_expenses
    result = 0
    financial_info = self.student_financial_information
    if !financial_info.nil?
      result = financial_info.expenses_academic_activities.to_f +
        financial_info.home_expenses.to_f + 
        financial_info.dependent_expenses.to_f + 
        financial_info.personal_goods_expenses.to_f + 
        financial_info.transportation_expenses.to_f + 
        financial_info.food_expenses.to_f
    end
    return result
  end

  def total_application_income
    result = 0
    financial_info = self.student_financial_information
    if !financial_info.nil?
      result = financial_info.total_personal_income.to_f + financial_info.family_support_value.to_f
    end
    return result
  end

  def student_positive_balance
    self.student_balance >= 0
  end

  def student_balance
    self.total_application_income - self.total_expenses
  end

  def colombia_range_personal_debt
    colombia_debt_range(self.personal_debt)
  end

  def colombia_range_mortgage_debt
    colombia_debt_range(self.mortgage_debt)
  end

  def colombia_range_education_debt
    colombia_debt_range(self.education_debt)
  end

  def colombia_range_other_debt
    colombia_debt_range(self.other_debt)
  end

  def colombia_range_total_debt
    colombia_debt_range(self.total_debt)
  end

  def colombia_salary_range
    colombia_salary_general_range(self.total_income)
  end

  def fixed_income
    self.active_income_information.map{ |a| a.fix_income.to_f * a.exchange_rates}.sum
  end

  def variable_income
    self.active_income_information.map{ |a| a.variable_income.to_f * a.exchange_rates}.sum
  end

  def has_active_presumptive_income?
    self.active_income_information.where(presumptive_income: true).any?
  end

  def fixed_income_preloaded
    self.active_income_information.map{|income| income.fix_income.to_f * income.exchange_rates}.inject(:+)
  end

  def variable_income_preloaded
    self.active_income_information.map{|income| income.variable_income.to_f * income.exchange_rates}.inject(:+)
  end


  def total_income billing_document_id = nil
    if billing_document_id.nil?
      self.fixed_income + self.variable_income
    else
      billing_document = BillingDocument.find(billing_document_id)
      variable_income = billing_document.fund.automatic_variable_income ? billing_document.variable_income : self.variable_income
      self.fixed_income + variable_income
    end
  end

  def children_average_age
    ages = self.child.map{|a| a.age}
    if ages.count > 0
      result = ages.inject{ |sum, el| sum + el }.to_f / ages.size
    else
      result = 0
    end
    return result
  end


  def children_range value
    if value == 0
      result = 'no_children'
    elsif value <= 5
      result = '0-5'
    elsif value <= 12
      result = '6-12'
    elsif value <= 17
      result = '13-17'
    else
      result = '> 18'
    end
    return result
  end

  def colombia_debt_range value
    if value == 0
      result = '0-0'
    elsif value <= 50000
      result = '1 - 50.000'
    elsif value <= 75000
      result = '50.000 - 75.000'
    elsif value <= 100000
      result = '75.000 - 100.000'
    elsif value <= 5000000
      result = '150.000 - 5.000.000'
    else
      result = '> 5.000.000'
    end
    return result
  end

  def colombia_salary_general_range value
    if value == 0
      result = '0-0'
    elsif value <= 50000
      result = '1 - 700.000'
    elsif value <= 75000
      result = '700.000 - 1.000.000'
    elsif value <= 100000
      result = '1.000.000 - 2.000.000'
    elsif value <= 5000000
      result = '2.000.000 - 4.000.000'
    elsif value <= 7000000
      result = '4.000.000 - 7.000.000'
    elsif value <= 10000000
      result = '7.000.000 - 10.000.000'
    else
      result = '> 10.000.000'
    end
    return result
  end


  def personal_debt
    self.student_debt.where(type_of_debt: 'personal').sum(:amount)
  end

  def mortgage_debt
    self.student_debt.where(type_of_debt: 'mortgage').sum(:amount)
  end

  def education_debt
    self.student_debt.where(type_of_debt: 'education').sum(:amount)
  end

  def other_debt
    self.student_debt.where(type_of_debt: 'other').sum(:amount)
  end

  def total_debt
    self.student_debt.sum(:amount)
  end

  def total_debt_sum
    self.student_debt.map{|debt| debt.amount}.reduce(:+)
  end

  def funded_program
    self.funded_academic_information.major unless self.funded_academic_information.nil?
  end

  def funded_institution
    self.funded_academic_information.institution unless self.funded_academic_information.nil?
  end

  def age
    if self.personal_information.birthday.nil?
      result = nil
    else
      result = ((Time.zone.now - self.personal_information.birthday.to_time) / 1.year.seconds).floor
    end
    return result
  end

  def academics
    self.student_academic_information.kept.includes(:school_info,:university_info,:institution,:major).to_a
  end

  def notifications_count
    self.pending_notifications.size
  end

  def cached_pending_notifications
    Rails.cache.fetch(['pending_notifications',self.id]){pending_notifications}
  end

  def pending_notifications
    self.notification.where(got_it: false).to_a
  end

  def student_account
    self.type_of_account == 'student'
  end

  def questionnaire_status
    status = 'finished'
    self.cached_ongoing_questionnaire.each do |questionnaire|
      if !questionnaire.end_time.nil? && questionnaire.end_time < Time.now || questionnaire.status == 'finished'
        questionnaire.status = 'finished'
        questionnaire.save
      else
        status = 'ongoing'
      end
    end
    return status
  end

  def cached_ongoing_questionnaire
    Rails.cache.fetch(['cached_ongoing_questionnaire',self.id],expires_in: 8.days){ongoing_questionnaire.to_a}
  end

  def cached_questionnaire_mode?
    Rails.cache.fetch(['cached_questionnaire_mode',self.id],expires_in: 8.days){questionnaire_mode?}
  end

  def ongoing_questionnaire
    self.user_questionnaire.includes(:questionnaire).where(status: 'ongoing').where(questionnaires: {type_of_quesitonnaire: 'time_trial'}).kept
  end

  def questionnaire_mode?
    self.ongoing_questionnaire.count > 0
  end

  def own_project
    self.projects.where(person_project: true).first
  end

  def current_application
      if self.new_agreement?
        target_application = self.new_agreement
      else
        target_application = self.active_application
        if target_application.nil?
          target_application = self.submitted_application
        end
      end
      return target_application
  end

  def current_application_for_committee
    target_application = self.application.select{|a| a.resource_type == 'FundingOpportunity'}.last
    return target_application
  end

  def submitted_application
    self.application.select{|a| a.status == "submitted"}.select{|a| a.resource_type == ("FundingOpportunity" || "Isa")}.last
  end


  def active_application
    self.application.select{|a| a.status == "active"}.select{|a| a.resource_type == ("FundingOpportunity" || "Isa")}.last
  end


  def application_funding_opportunity
    self.ongoing_application.funding_opportunity.name unless self.ongoing_application.nil?
  end

  def target_tasks_by_type target_task_type
    ProjectTask.joins(:project_task_type).where(responsable_id: self.id,project_task_types: {title: target_task_type})
  end

  def student?
    self.student_account
  end

  def self.students
    User.where(type_of_account: 'student').kept
  end

  def template model, controller,current_user,options = {}
    target_template = {}
    if options[:id] == true
      target_template[:id] = {hidden: false}
    end
    temp_hash = self.team_profile.team_profile_template.joins(:form_template).where(controller_name: controller,form_templates: {object: model}).first.form_template.cached_template_hash(current_user,options[:current_company])
    target_template = target_template.merge(temp_hash) 
    return target_template
  end

  def self.assigned_students current_user_id, current_company_id
    current_user = User.cached_find(current_user_id)
    current_company = Company.cached_find(current_company_id)
    User.where(company_id: current_company.access_companies, type_of_account: 'student',id: current_user.fullTeam).kept
  end

  def project_name
    if self.own_project.title != self.name
      self.own_project.update_attributes(title: self.name)
    end
  end

  def cached_approver_list
    Rails.cache.fetch([self,'approver_list']){approval_match.map{|s| [s.approver_role, s.approver_id]}.to_h}
  end
  def flush_avatar
    Rails.cache.delete([self,'avatar'])
    Rails.cache.delete([self,'attached_avatar'])
  end

  def cached_attached_avatar?
    Rails.cache.fetch([self,'attached_avatar']){avatar.attached?}
  end

  def cached_avatar size
    Rails.cache.fetch([self,'avatar',size, expires_in: 30.minutes]){avatar.variant(resize: '100x100').processed.image}
  end

  def cached_roles
    if !self.team_profile.nil?
      Rails.cache.fetch([self.team_profile.name, 'roles']) {team_profile.roles.to_a}
    end
  end

  def cached_role_names
    if !self.team_profile_id.nil?
      Rails.cache.fetch([self.team_profile_id,'role_names']) {team_profile.cached_role_names}
    else
      []
    end
  end

  def cached_has_role?(target_role)
    if !self.cached_role_names.nil?
      self.cached_role_names.include?(target_role)
    end
  end

  def name
    result = self.first_name if !self.first_name.nil?
    result += ' ' + self.middle_name if !self.middle_name.nil?
    result += ' ' + self.last_name if !self.last_name.nil?
  end

  def flush_cached_roles
    if !self.team_profile.nil?
      Rails.cache.delete([self.team_profile.name,'roles'])
      Rails.cache.delete([self.team_profile.name,'role_names'])
    end
  end


  def create_contact_info
    ContactInfo.create({contact_email: self.email, resource: self})
  end
  def create_location
    Location.create(resource: self)
  end

  def create_personal_information
    PersonalInformation.create(user_id: self.id)
  end

  def create_complementary_activity
    ComplementaryActivity.create(user_id: self.id)
  end


  def active_for_authentication?
    super && !discarded?
  end

  def thumbnail
    return self.avatar.variant(resize: '300x300!').processed
  end

  def set_locale
    self.language = self.company.default_language
  end

  def company_name
    self.company.name
  end

  def skip_confirmation
    self.skip_confirmation! if self.migrated
  end

  def allowed_view?(params)
    self.cached_has_role?(params[:controller] + '_view')
  end

  def allowed_create?(params)
    self.cached_has_role?(params[:controller] + '_create') || self.cached_has_role?(params[:controller] + '_create_with_approval')
  end

  def allowed_create_with_approval?(params)
    self.cached_has_role?(params[:controller] + '_create_with_approval')
  end

  def allowed_update?(params)
    self.cached_has_role?(params[:controller] + '_update') || self.cached_has_role?(params[:controller] + '_update_with_approval')
  end

  def allowed_update_with_approval?(params)
    self.cached_has_role?(params[:controller] + '_update_with_approval')
  end

  def allowed_destroy?(params)
    self.cached_has_role?(params[:controller] + '_destroy') || self.cached_has_role?(params[:controller] + '_destroy_with_approval')
  end

  def allowed_destroy_with_approval?(params)
    self.cached_has_role?(params[:controller] + '_destroy_with_approval')
  end


  def allowed_just_view?(params)
    allRoles = self.cached_role_names
    options = ['create','update','destroy','create_with_approval','update_with_approval','destroy_with_approval']
    roleOptions = options.map{|o| params[:controller] + '_' + o} 
    validation = allRoles.include?(params[:controller] + '_view') && !roleOptions.map{|r| allRoles.include?(r)}.include?(true)
    return validation
  end

  def supervisors
    supervisors = self.reporting_to.ids
    tempSupervisors = supervisors
    verifier = true
    while verifier do
      if tempSupervisors.length > 0
        targetSupervisor = TeamSupervisor.where(team_member_id: tempSupervisors).map{|member| member.team_member}
        tempSupervisors = targetSupervisor - supervisors
        supervisors += tempSupervisors
      else
        verifier = false
      end
    end
    return supervisors
  end

  def fullTeam
    teamMembers = [self.id]
    partialMembers = [self.id]
    verifier = true
    while verifier do 
      if partialMembers.length > 0
        addMembers = TeamSupervisor.joins(:team_member).where(users:{type_of_account: "staff"}).where(supervisor_id: partialMembers).pluck(:team_member_id)
        partialMembers = addMembers - teamMembers
        teamMembers += partialMembers
      else
        verifier = false
      end
    end
    return teamMembers
  end


  def initials
    temText = ''
    temText += self.first_name[0].nil? ? '' : self.first_name[0]
    temText += self.last_name[0].nil? ? '' : self.last_name[0]
    temText.upcase
  end

  def startProject

    newProject = Project.create({title: self.name,position: 1, private: true,owner_id: self.id,person_project: true})
    setDefaults newProject.id

    createAccountTask = ProjectTaskType.find_by_title('account_creation')
    newCreateTask = ProjectTask.create(title: createAccountTask.title, deadline: Date.today + 15, responsable_id: self.id, created_by_id: self.id,
      project_task_type_id: createAccountTask.id,project_card_id: newProject.project_card.third.id, position: 1, locked: true,progress: 50)

    confirmEmailTask = ProjectTaskType.find_by_title('confirm_email')
    newConfirmTask = ProjectTask.create(title: confirmEmailTask.title, deadline: Date.today + 8, responsable_id: self.id, created_by_id: self.id,
      project_task_type_id: confirmEmailTask.id,project_card_id: newProject.project_card.third.id, position: 1, locked: true,parent_id: newCreateTask.id,progress: 0)
  end

  def setDefaults projectId
    defaultCards = ['on-hold','in-progress','under-review','done']
    defaultCards.each_with_index do |card, index|
      tempCard = ProjectCard.create({title: card,position: index,project_id: projectId})
    end
  end

  def supervisor_in_charge
    reporting_to.map{|v| v.supervisor.name }.join(" // ")
  end

  def fund
    self.funding_opportunity_applications.map{|application| application.funding_opportunity_from_resource.fund.name}.join(',')
  end

  def mobile
    self.contact_info.mobile
  end

  def city_of_recidence
    self.location.city.label unless self.location.city.nil?
  end

  def application_status
    self.application.first.status  unless self.application.first.nil?
  end

  def application_decision
    self.application.first.decision unless self.application.first.nil?
  end

  def application_score
    self.application.first.score unless self.application.first.nil?
  end
  
  def major
    self.funded_programs.last.major.potential_not_approved_version.name unless self.funded_programs.last.nil? || self.funded_programs.last.major.nil?
  end

  def institution
    self.funded_programs.last.institution.potential_not_approved_version.name unless self.funded_programs.last.nil? || self.funded_programs.last.institution.nil?
  end

  def academic_level
    self.funded_programs.last.major.potential_not_approved_version.academic_level unless self.funded_programs.last.nil? || self.funded_programs.last.major.nil?
  end

  def program_number_of_terms
    self.funded_programs.last.potential_not_approved_version.program_number_of_terms unless self.funded_programs.last.nil?
  end

  def number_of_disbursements_requiered
    self.funded_programs.last.potential_not_approved_version.number_of_disbursements_requiered unless self.funded_programs.last.nil?
  end

  def gender
    self.personal_information.gender
  end

  def strata
    self.sociodemographic.strata unless self.sociodemographic.nil?
  end

  def ethnicity
    self.sociodemographic.ethnicity unless self.sociodemographic.nil?
  end

  def indigenous_community
    self.sociodemographic.indigenous_community unless self.sociodemographic.nil?
  end

  def contract_case
    self.income_information.last.contract_case unless self.income_information.last.nil?
  end

  def origin_state
    self.sociodemographic.state.label unless self.sociodemographic.nil?
  end

  def origin_city
    self.sociodemographic.city.label unless self.sociodemographic.nil?
  end

  def location_state
    self.location.state.label unless self.location.state.nil?
  end

  def location_city
    self.location.city.label unless self.location.city.nil?
  end

  def current_academic_status
    self.funded_programs.last.current_academic_status unless self.funded_programs.last.nil?
  end

  def current_term
    self.funded_programs.last.current_term unless self.funded_programs.last.nil?
  end

  def application_result
    self.application.first.result
  end

  def number_of_disbursements_requiered
    self.funded_programs.last.number_of_disbursements_requiered unless self.funded_programs.last.nil?
  end

  def total_number_of_disbursement_tuition_payed
    self.funded_programs.last.disbursement.select{|v| v.status == "payed" && v.disbursement_case == "tuition"}.count
  end
  
  def total_value_of_disbursement_tuition_payed
    self.funded_programs.last.disbursement.select{|v| v.status == "payed" && v.disbursement_case == "tuition"}.pluck(:student_value).reduce(:+)
  end
  
  def total_number_of_disbursement_living_expenses_payed
    self.funded_programs.last.disbursement.select{|v| v.status == "payed" && v.disbursement_case == "living_expenses"}.count
  end
  
  def total_value_of_disbursement_living_expenses_payed
    self.funded_programs.last.disbursement.select{|v| v.status == "payed" && v.disbursement_case == "living_expenses"}.pluck(:student_value).reduce(:+)
  end

  def last_conection
    self.last_sign_in_at
  end

  def questionnaire_result
    self.user_questionnaire.map{|q| "#{q.questionnaire.name}: #{q.final_result} (#{q.main_score})" }.join("//") unless self.user_questionnaire.nil?
  end

  def funding_opportunity_belongs
    self.funding_opportunity_applications.map{ |application| application.funding_opportunity_from_resource.name}.join(',')
  end

  def personal_birthday
    self.personal_information.birthday
  end

  def standardized_state_test_result
    self.funded_programs.last.standardized_state_test_result unless self.funded_programs.last.nil?
  end

  def program_level
    self.funded_programs.last.program_level unless self.funded_programs.last.nil?
  end

  def last_period_score
    self.funded_programs.last.last_period_score unless self.funded_programs.last.nil?
  end

  def score_scale
    self.funded_programs.last.score_scale unless self.funded_programs.last.nil?
  end
  
  def number_subjects_failed
    self.funded_programs.last.university_info.number_subjects_failed unless self.funded_programs.last.university_info.nil? unless self.funded_programs.last.nil?
  end

  def dependent_number
    self.sociodemographic.dependent_number unless self.sociodemographic.nil?
  end

  def children_number
    self.sociodemographic.children_number unless self.sociodemographic.nil?
  end

  def siblings_number
    self.sociodemographic.siblings_number unless self.sociodemographic.nil?
  end

  def siblings_position
    self.sociodemographic.siblings_position unless self.sociodemographic.nil?
  end

  def siblings_position
    self.sociodemographic.siblings_position unless self.sociodemographic.nil?
  end

  def main_financial_support_person
    self.sociodemographic.main_financial_support_person unless self.sociodemographic.nil?
  end

  def family_living_together
    self.sociodemographic.family_living_together unless self.sociodemographic.nil?
  end

  def child_birthday
    self.child.map{|c| c.birthday}.join(' / ')
  end

  def marital_status
    self.personal_information.marital_status
  end

  def city_of_study
    self.funded_programs.last.city.label unless self.funded_programs.last.nil? || self.funded_programs.last.city.nil?
  end

  def type_of_debt
    self.student_debt.first.type_of_debt unless self.student_debt.first.nil?
  end

  def first_reference_relationship
    self.reference.first.relationship unless self.reference.first.nil?
  end

  def second_reference_relationship
    self.reference.second.relationship unless self.reference.second.nil?
  end

  def first_references_education_level
    self.reference.first.education_level unless self.reference.first.nil?
  end

  def second_references_education_level
    self.reference.second.education_level unless self.reference.second.nil?
  end

  def first_references_labor_situation
    self.reference.first.labor_situation unless self.reference.first.nil?
  end

  def second_references_labor_situation
    self.reference.second.labor_situation unless self.reference.second.nil?
  end

  def state_of_recidence
    self.location.state.label unless self.location.state.nil?
  end

  def institution_name
    self.funded_programs.last.institution.name unless self.funded_programs.last.nil? || self.funded_programs.last.institution.nil?
  end

  def major_name
    self.funded_programs.last.major.name unless self.funded_programs.last.nil? || self.funded_programs.last.major.nil?
  end

  #first reference
  def references_first_validation_status
    self.reference.first.validation_status unless self.reference.first.nil?
  end

  def references_first_guardian
    self.reference.first.guardian unless self.reference.first.nil?
  end

  def references_first_relationship
    self.reference.first.relationship unless self.reference.first.nil?
  end

  def reference_first_first_name
    self.reference.first.first_name unless self.reference.first.nil?
  end

  def reference_first_last_name
    self.reference.first.last_name unless self.reference.first.nil?
  end

  def reference_first_mobile
    self.reference.first.mobile unless self.reference.first.nil?
  end

  def reference_first_work_phone
    self.reference.first.work_phone unless self.reference.first.nil?
  end

  def reference_first_identification_number
    self.reference.first.identification_number unless self.reference.first.nil?
  end

  def reference_first_email
    self.reference.first.reference_email unless self.reference.first.nil?
  end

  def reference_first_jointly_liable
    self.reference.first.jointly_liable unless self.reference.first.nil?
  end

  #second reference
  def references_second_validation_status
    self.reference.second.validation_status unless self.reference.second.nil?
  end

  def references_second_guardian
    self.reference.second.guardian unless self.reference.second.nil?
  end

  def references_second_relationship
    self.reference.second.relationship unless self.reference.second.nil?
  end

  def reference_second_first_name
    self.reference.second.first_name unless self.reference.second.nil?
  end

  def reference_second_last_name
    self.reference.second.last_name unless self.reference.second.nil?
  end

  def reference_second_mobile
    self.reference.second.mobile unless self.reference.second.nil?
  end

  def reference_second_work_phone
    self.reference.second.work_phone unless self.reference.second.nil?
  end

  def reference_second_identification_number
    self.reference.second.identification_number unless self.reference.second.nil?
  end

  def reference_second_email
    self.reference.second.reference_email unless self.reference.second.nil?
  end

  def reference_second_jointly_liable
    self.reference.second.jointly_liable unless self.reference.second.nil?
  end

    #third reference
    def references_third_validation_status
      self.reference.third.validation_status unless self.reference.third.nil?
    end
  
    def references_third_guardian
      self.reference.third.guardian unless self.reference.third.nil?
    end
  
    def references_third_relationship
      self.reference.third.relationship unless self.reference.third.nil?
    end
  
    def reference_third_first_name
      self.reference.third.first_name unless self.reference.third.nil?
    end
  
    def reference_third_last_name
      self.reference.third.last_name unless self.reference.third.nil?
    end
  
    def reference_third_mobile
      self.reference.third.mobile unless self.reference.third.nil?
    end
  
    def reference_third_work_phone
      self.reference.third.work_phone unless self.reference.third.nil?
    end
  
    def reference_third_identification_number
      self.reference.third.identification_number unless self.reference.third.nil?
    end
  
    def reference_third_email
      self.reference.third.reference_email unless self.reference.third.nil?
    end
  
    def reference_third_jointly_liable
      self.reference.third.jointly_liable unless self.reference.third.nil?
    end
  
    #fourth reference
    def references_fourth_validation_status
      self.reference.fourth.validation_status unless self.reference.fourth.nil?
    end
  
    def references_fourth_guardian
      self.reference.fourth.guardian unless self.reference.fourth.nil?
    end
  
    def references_fourth_relationship
      self.reference.fourth.relationship unless self.reference.fourth.nil?
    end
  
    def reference_fourth_first_name
      self.reference.fourth.first_name unless self.reference.fourth.nil?
    end
  
    def reference_fourth_last_name
      self.reference.fourth.last_name unless self.reference.fourth.nil?
    end
  
    def reference_fourth_mobile
      self.reference.fourth.mobile unless self.reference.fourth.nil?
    end
  
    def reference_fourth_work_phone
      self.reference.fourth.work_phone unless self.reference.fourth.nil?
    end
  
    def reference_fourth_identification_number
      self.reference.fourth.identification_number unless self.reference.fourth.nil?
    end
  
    def reference_fourth_email
      self.reference.fourth.reference_email unless self.reference.fourth.nil?
    end
  
    def reference_fourth_jointly_liable
      self.reference.fourth.jointly_liable unless self.reference.fourth.nil?
    end

    def expected_graduation_date
      self.funded_programs.last.expected_graduation_date unless self.funded_programs.last.nil?
    end

    def graduation_date
      self.funded_programs.last.graduation_date unless self.funded_programs.last.nil?
    end

    def isa_stored_general_status
      self.funded_programs.last.isa.last.stored_general_status unless self.funded_programs.last.nil? || self.funded_programs.last.isa.last.nil?
    end

    def isa_stored_payment_status
      self.funded_programs.last.isa.last.stored_payment_status unless self.funded_programs.last.nil? || self.funded_programs.last.isa.last.nil?
    end

    def isa_stored_income_status
      self.funded_programs.last.isa.last.stored_income_status unless self.funded_programs.last.nil? || self.funded_programs.last.isa.last.nil?
    end

    def stored_academic_information
      self.funded_programs.last.stored_academic_information unless self.funded_programs.last.nil?
    end

    def active_income_position
      self.active_income_information.last.position unless self.active_income_information.last.nil?
    end

    def active_income_company_name
      self.active_income_information.last.company_name unless self.active_income_information.last.nil?
    end

    def active_income_start_date
      self.active_income_information.last.start_date unless self.active_income_information.last.nil?
    end

    def active_income_end_date
      self.active_income_information.last.end_date unless self.active_income_information.last.nil?
    end

    def active_income_currency
      self.active_income_information.last.currency unless self.active_income_information.last.nil?
    end

    def active_income_fix_income
      self.active_income_information.last.fix_income unless self.active_income_information.last.nil?
    end

    def active_income_variable_income
      self.active_income_information.last.variable_income unless self.active_income_information.last.nil?
    end

    def active_income_total_income
      (active_income_fix_income.to_f + active_income_variable_income.to_f) unless self.active_income_information.last.nil?
    end

    def active_income_created_at
      self.active_income_information.last.created_at unless self.active_income_information.last.nil?
    end

    def active_income_updated_at
      self.active_income_information.last.updated_at unless self.active_income_information.last.nil?
    end

    def active_income_income_case
      self.active_income_information.last.income_case unless self.active_income_information.last.nil?
    end

    def active_income_contract_case
      self.active_income_information.last.contract_case unless self.active_income_information.last.nil?
    end

    def new_agreement?
      new_agreement.present?
    end

    def new_agreement
      self.application
          .includes([:funding_opportunity, :legal_match, :funding_option, :program_to_fund, :modeling_match, :original_application])
          .order(:created_at)
          .select{|v| v.application_case == "add_disbursement_modeling" && v.status == 'submitted'}
          .last
    end

    def mentory_employability_invitation?
      mentory_employability_invitation.present?
    end

    def mentory_employability_invitation
      self.application
      .select{|a| a.application_case == "mentory_empleability_invitation"}
      .select{|a| a.status == 'active'}
      .last
    end
  
    def university_grade
      self.funded_programs.last.university_grade.last unless self.funded_programs.last.university_grade.nil?
    end

    def university_courses_grades
      self.university_grade.university_course_grade.map{|g| "#{g.name}: #{g.final_score}" }.join("// ")
    end

    def average_grade_of_term
      self.university_grade.grade
    end

    def funded_program_last_period_score
      self.funded_programs.last.last_period_score
    end

    def projected_salary
      ProjectedSalaryService.for(self)
    end

    def academic_stage?
      ['studing', 'academic_stop'].include? self.active_isa.first.stored_academic_status
    end

    def work_stage?
      ['graduation_process', 'graduated', 'drop_out'].include? self.active_isa.first.stored_academic_status
    end

    def user_document_type_for_signio
      case self.personal_information.document_type
      when 'cedula','cc'
        return 'CC'
      when 'immigration_cedula', 'ce'
        return 'CE'
      when 'Pasaporte', 'passport', 'Pasaport'
        return 'PS'
      when 'ti'
        return 'TI'
      else
        return 'OT'
      end
    end
end
