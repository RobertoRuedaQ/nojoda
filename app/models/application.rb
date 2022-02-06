class Application < ApplicationRecord
  include LumniModeling
  include LumniFinance
  resourcify
  audited
  belongs_to :user, touch: true
	belongs_to :funding_opportunity, optional: true
  belongs_to :resource, polymorphic: true, touch: true

  belongs_to :funding_opportunity_from_resource,->{joins(:application).where(applications:{resource_type: 'FundingOpportunity'})},class_name: 'FundingOpportunity',foreign_key: 'resource_id',optional: true
  belongs_to :disbursement,->{joins(:application).where(applications:{resource_type: 'Disbursement'})},class_name: 'Disbursement',foreign_key: 'resource_id',optional: true
  belongs_to :income_information,->{joins(:application).where(applications:{resource_type: 'IncomeInformation'})},class_name: 'IncomeInformation',foreign_key: 'resource_id',optional: true

  belongs_to :original_application, class_name: 'Application', foreign_key: 'original_application_id', optional: true

  has_many :origination_section

  scope :full_application, ->{includes(:user_questionnaire, :legal_match, :application_section_track, :project_task, :modeling_match, :funding_option,:funding_opportunity_from_resource,[funding_opportunity_from_resource: [origination: :origination_module]])}
  has_many :user_questionnaire,->{joins(origination_section: [origination_module: :origination]).where('originations.discarded_at IS NULL AND origination_modules.discarded_at IS NULL AND origination_sections.discarded_at IS NULL').distinct}, dependent: :destroy
  has_many :legal_match, dependent: :destroy
  has_many :application_section_track, dependent: :destroy
  has_many :project_task, as: :resource, dependent: :destroy
  has_one :modeling_match, dependent: :destroy
  has_many :funding_option,->{where(model_status: ["done",'failed']).order(:isa_term)}, dependent: :destroy
  has_many :invalid_funding_option, -> {where.not(model_status: 'done').or(where(model_status: nil))},class_name: 'FundingOption', foreign_key: 'application_id', dependent: :destroy
  has_one :program_to_fund,->{where(information_case: "to_be_funded")}, class_name: 'StudentAcademicInformation', foreign_key: 'application_id',dependent: :destroy
  has_one :disbursement_request, dependent: :destroy
  has_one :questionnaire_review,->{joins(:questionnaire).where(questionnaires:{category: 'review'})}, class_name: 'UserQuestionnaire', foreign_key: 'application_id'
  has_one :questionnaire_ongoing_review,->{joins(:questionnaire).where(status: "ongoing",questionnaires:{category: 'review'})}, class_name: 'UserQuestionnaire', foreign_key: 'application_id'
  has_one :questionnaire_pending_review,->{joins(:questionnaire).where(status: ["active","pending"],questionnaires:{category: 'review'})}, class_name: 'UserQuestionnaire', foreign_key: 'application_id'

  has_many :student_academic_information, dependent: :destroy
  has_many :social_work, dependent: :destroy
  has_many :requesting_modification, dependent: :destroy
  has_many :active_requesting_modification,->{where(status: 'active').kept},class_name: 'RequestingModification', foreign_key: 'application_id', dependent: :destroy
  has_one :application_committee
  has_many :application_follow_up, dependent: :destroy
  has_many :application_module_track


  has_one :active_questionnaire, ->{where(status: ['active',"ongoing"])}, class_name: 'UserQuestionnaire', foreign_key: 'application_id'
  has_one :university_grade, class_name: 'UniversityGrade', foreign_key: 'application_id', dependent: :nullify


  before_save :set_funding_opportunity
  after_commit :set_funding_options_display_date, on: [:create, :update]
  after_commit :set_disbursement_matches, on: [:create, :update]
  after_commit :set_disbursement_cancellations, on: [:create, :update]
  after_commit :set_conciliation_adjustment, on: [:create, :update]
  after_commit :update_requesting_modification, on: [:create, :update]
  after_commit :set_income_information_status, on: [:create, :update]

  enum typology: { default: 0, blackrock: 1, mentory_empleability: 2 }

  def set_income_information_status
    if self.resource_type == 'IncomeInformation' && self.status == 'approved' && self.resource.status == 'under_review'
      self.resource.update_column('status', 'active')
      if self.resource.parent.present?
        self.resource.parent.update(end_date: self.resource.start_date)
      end
      self.user.active_isa.map{|i| ModelClassesAsync.perform_async('Isa', 'save', i.id)}
    end
  end

  def typology_special_scenario?
    ['blackrock', 'mentory_empleability'].include?(self.typology)
  end

  def last_change_by
    return  I18n.t('application.migrated') if self.migrated
 
    changes = last_updated_audit
    changes.any? ? changes.last.user.full_name : ''
  end

  def last_change_at
    return  I18n.t('application.migrated') if self.migrated

    changes = last_updated_audit
    changes.any? ? changes.last.created_at.to_date : nil
  end
  
  def last_updated_audit
    self.audits.where(action: 'update').where.not(user_id: self.user.id)
  end

  def set_conciliation_adjustment
    if self.resource_type == 'ConciliationInformation' && self.status == 'approved' && self.resource.payment_agreement.nil? && self.resource.payment.nil?
      conciliation = self.resource
      target_value = conciliation.difference_value

      if target_value > 0
        #student underpayed
        payment_agreement = conciliation.payment_agreement
        if payment_agreement.nil?
          payment_agreement = PaymentAgreement.create({ value: target_value, rate: conciliation.isa.funding_opportunity.payment_config.conciliation_rate.to_f, number_payments: 1, status: "pending", agreement_case: "conciliation",start_date: Time.now.to_date, end_date: nil, isa_id: conciliation.isa_id})
          conciliation.update_column('payment_agreement_id',payment_agreement.id)
        else
          payment_agreement = PaymentAgreement.update({ value: target_value, rate: conciliation.isa.funding_opportunity.payment_config.conciliation_rate.to_f, number_payments: 1, status: "pending", agreement_case: "conciliation",start_date: Time.now.to_date, end_date: nil, isa_id: conciliation.isa_id})
        end
      elsif target_value < 0
        payment = conciliation.payment
        if payment.nil?
          payment = Payment.create({billing_document_id: isa.billing_document.last.id, status: "active",payment_source: "conciliation", payment_method: "conciliation", value: target_value,resource_type: "ConciliationInformation", resource_id: conciliation.id, payment_date: Time.now.to_date})
        else
          payment = Payment.update({billing_document_id: isa.billing_document.last.id, status: "active",payment_source: "conciliation", payment_method: "conciliation", value: target_value,resource_type: "ConciliationInformation", resource_id: conciliation.id, payment_date: Time.now.to_date})
        end
      end
    end    
  end


  def set_disbursement_cancellations
    if self.resource_type == 'CancellationRequest' && self.status == 'approved'
      if self.resource.disbursement.present?
        self.resource.disbursement.apply_cancellations_after_disbursement
      elsif self.resource.isa.present?
        self.resource.isa.apply_cancellations_after_graduation
      end
    end
  end

  def remodeling?
    self.application_case == 'add_disbursement_modeling'
  end


  def isa_creation?
    self.resource_type == 'FundingOpportunity'
  end


  def active_questionnaire_id
    self.active_questionnaire.id
  end


  def pending_test_id
    if self.resource.active_questionnaire.nil?
      result = self.user_questionnaire.where(status: ['active',"ongoing"]).first.id
      if result.nil?
        result = 'na'
      end
    else
      result = self.resource.active_questionnaire
    end
    return result
  end

  def update_requesting_modification
    puts 'update_requesting_modification'
    if self.status == 'submitted'
      self.active_requesting_modification.update_all(status: 'inactive')
    end
  end

  def modeling
    modeling_students self
  end

  def direct_funding_opportunity
    self.resource
  end


  def set_funding_opportunity
    begin
      self.funding_opportunity_id = self.funding_opportunity_logic.id
    rescue Exception => e
      
    end
  end

  def funding_opportunity_logic
    case self.resource_type
    when 'FundingOpportunity'
      result = FundingOpportunity.find(self.resource_id)
    when 'StudentAcademicInformation'
      result =self.resource.application.funding_opportunity_from_resource
    when 'Isa'
      result = self.original_application.resource
    when 'Disbursement'
      result =self.resource.funding_option.application.funding_opportunity
    when 'IncomeInformation'
      result = self.resource.user.funding_opportunity_applications.map{ |application| application.funding_opportunity_from_resource}.first
    when 'CovidEmergency'
      result = self.resource.user.funding_opportunity_applications.map{ |application| application.funding_opportunity_from_resource}.first
    when 'Payment'
      result = self.resource.billing_document.isa.funding_opportunity
    when 'AcademicRequest'
      result = self.resource.student_academic_information.application.resource
    else
      result = self.resource.funding_opportunity
    end
    return result
  end

  def belongs_to_fund
    return unless self.funding_opportunity

    self.funding_opportunity.fund.name
  end

  def current_questionnaire
    section = self.current_section
    if section.resource_type == "Questionnaire"
      result = self.user_questionnaire.find_by(questionnaire_id: section.resource_id)
    else
      result = nil
    end
    return result
  end

  def set_disbursement_matches
    puts 'set_disbursement_matches'
    if self.resource_type == 'Disbursement' && self.status == 'pending' && self.result == 'approved' && self.migrated != true
      self.update(status: 'approved')
      disbursement = self.resource 
      disbursement_request = self.disbursement_request

      approved_value =  if disbursement_request.disbursement_case == 'reimbursement_of_money'
                          disbursement_request.reimbursement_value.to_f
                        else
                          disbursement_request.disbursement_value.to_f
                        end
      #in case exist previous disbursement matches, must be deleted to avoid redundancy
      if disbursement.disbursement_match.any?
        DisbursementMatch.joins(:disbursement).where(disbursement_request_id: self.disbursement_request.id).where(disbursements: {disbursement_case: disbursement.disbursement_case}).destroy_all
      end

      # Regular asigment
      main_disbursement = [approved_value.to_f, self.resource.student_value].min
      DisbursementMatch.create({disbursement_id: self.resource_id, disbursement_request_id: self.disbursement_request.id, values: main_disbursement})

      # Use of previous disbursements
      disbursements_2 = [approved_value.to_f - main_disbursement.to_f, 0].max
      if disbursements_2 > 0
        value_applied = 0
        other_disbursements = self.resource.funding_option.disbursement.where.not(disbursement_number: self.resource.disbursement_number).where(disbursement_case: disbursement.disbursement_case).order(:disbursement_number)
        other_disbursements.each do |dis|
          temp_value = [dis.free, disbursements_2 - value_applied].min
          if temp_value > 0
            DisbursementMatch.create({disbursement_id: dis.id, disbursement_request_id: self.disbursement_request.id, values: temp_value})
            value_applied += temp_value
          end
        end
      end
      # Create Living Expenses
      if self.disbursement_request.living_expenses_check
        disbursement.associated_living_expenses.each do |living|
          DisbursementMatch.create({disbursement_id: living.id, disbursement_request_id: self.disbursement_request.id, values: living.student_value})
        end
      end
    end
  end

  def pending_user_questionnaire_by_section section
    self.user_questionnaire.find_by_status('pending')
  end

  def ongoing_user_questionnaire_by_section section
    self.user_questionnaire.find_by_status('ongoing')
  end

  def finished_user_questionnaire_by_section section
    self.user_questionnaire.find_by_status('finished')
  end

  def active_questionnaire_by_section section
    self.user_questionnaire.find_by_status(['ongoing','pending'])
  end

  def funded_major
    self.student_academic_information.find_by_information_case('to_be_funded')
  end

  def funding_opportunity_name
    if !self.funding_opportunity.nil?
      result = self.funding_opportunity.name
    end
    return result
  end

  def set_funding_options_display_date
    puts 'set_funding_options_display_date'
    if self.show_financial_proposals && !self.funding_options_display_date.nil?
      self.update(funding_options_display_date: Time.now.to_date)
    end
  end

  def offer_due_date
    result = nil
    if !self.funding_options_display_date.nil? && !self.funding_opportunity.offer_validity_days.nil?
      result = self.funding_options_display_date + self.funding_opportunity.offer_validity_days.days
    end
    return result
  end

  def cancellation_date
  end

  def company
    self.funding_opportunity.fund.company
  end

  def selected_funding_option
    self.funding_option.selected.first
  end

  def has_funding_options?
    self.funding_option.count > 0
  end

  def disbursements
    self.selected_funding_option.disbursement
  end

  def total_funded
    self.disbursements.sum(:student_value)
  end

  def disbursement_currency
    self.disbursements.first.currency
  end

  def active?
    self.status == 'active'
  end

  def submitted?
    self.status == 'submitted'
  end

  def verified?
    FundingToken.where(funding_opportunity_id: self.funding_opportunity_id, user_id: self.user_id,discarded_at: nil).count > 0
  end

  def task_by_type task_type
    self.project_task.kept.joins(:project_task_type).where(project_task_types: {title: task_type}).first
  end

  def t_status
    self.status
    #I18n.t('list.' + self.status) if !self.status.nil?
  end

  def document_signed? legal_document_id
    !self.signed_document(legal_document_id).nil?
  end

  def signed_document legal_document_id
    self.legal_match.kept.where(legal_document_id: legal_document_id).last
  end

  def current_module_number
    modules = self.resource.cached_modules_and_sections
    if self.status == 'approved'
      result = modules.count - 1
    else
      result = modules.map{|m| m.done?(self)}.index(false)
      if result.nil?
        result = modules.count
      end
    end
    return result
  end

  def final_module_number
    self.resource.cached_modules_and_sections
  end

  def current_section_number
		target_module = self.resource.cached_modules_and_sections[self.current_module_number]
		if target_module.present?
			sections = target_module.origination_section
			result = sections.map{|s| s.done?(self,s)}.index(false)
			if result.nil?
				result = sections.size
			end
		else
			result = nil
		end
		return result
  end

  def self.ransackable_scopes(auth_object = nil)
    %i(institution_name_cont supervisor_eq funding_opportunity_cont disbursement_case_eq disbursement_request_eq fund_cont)
  end

  def self.institution_name_cont(string)
    eager_load(user: [funded_programs: :institution]).where('lower(institutions.name) LIKE lower(?)', "%#{string}%")
  end

  def self.supervisor_eq(supervisor_id)
    eager_load({user: [reporting_to: :supervisor]}).where(user: { team_supervisors: { supervisor_id: supervisor_id}})
  end

  def self.funding_opportunity_eq(fo_id)
    where(funding_opportunities: { id: fo_id })
  end

  def self.funding_opportunity_cont(string)
    eager_load(:funding_opportunity).where('lower(funding_opportunities.name) LIKE lower(?)', "%#{string}%")
  end

  def self.fund_cont(string)
    eager_load(funding_opportunity: :fund).where('lower(funds.name) LIKE lower(?)', "%#{string}%")
  end

  def self.disbursement_case_eq(string)
    eager_load(:disbursement).where(application_case: 'disbursement_request').where(disbursements: { disbursement_case: string })
  end

  def self.disbursement_request_eq(string)
    result = where(application_case: 'disbursement_request').includes(disbursement_request: :pending_changes).select do |a|
      d = a.disbursement_request 
      if d.disbursement_case
        d.disbursement_case == string
      else
        d.pending_changes.last.params['disbursement_case'] == string if d.pending_changes.any?
      end
    end
    
    where(id: result.map(&:id))
  end

  def current_section_id
    self.current_section.id
  end

  def current_section
    result = nil
    if self.current_section_number.present?
      target_module = self.resource.cached_modules_and_sections[self.current_module_number]
      if target_module.present?
        target_section = target_module.origination_section[self.current_section_number - 1]
        if target_section.present?
          result = target_section
        end
      end
    end
    return result
  end

  def to_review?
    if self.to_review.present?
      result = self.to_review.category == 'review'
    else
      result = false
    end
    return result
  end
  
  def to_review
    if self.current_section.present? && self.current_section.resource_type == 'Questionnaire'
      result = self.current_section.resource
    else
      result = nil
    end
    return result
  end

  def task_by_type task_type  
    self.project_task.kept.joins(:project_task_type).where(project_task_types: {title: task_type}).first
  end

	def t_status
		self.status
		#I18n.t('list.' + self.status) if !self.status.nil?
	end

	def document_signed? legal_document_id
		!self.signed_document(legal_document_id).nil?
	end

	def signed_document legal_document_id
		self.legal_match.kept.where(legal_document_id: legal_document_id).last
	end

  def current_module_number
    modules = self.resource.modules_and_sections.includes(origination_section: [:application_section_track, {user_questionnaire: [:user_questionnaire_score, :questionnaire_exception]}])
		if self.status == 'approved'
			result = modules.size - 1
    else
			result = modules.map{|m| m.done?(self)}.index(false)
			if result.nil?
				case modules.last.option
				when "questionnaire"
					if modules.last.origination_section.last.resource.category == 'review'
						result = modules.size - 1
					else
						result = modules.size
					end
				else
					result = modules.size
				end
			end
		end
		return result
	end

	def current_section_id
		self.current_section.id
	end

  def supervisor_name
    self.user.reporting_to.first.supervisor.name unless self.user.reporting_to.first.nil?
  end

  def supervisors_in_charge
    self.user.reporting_to.map{|v| v.supervisor.name }.join(" // ")
  end

  def fund_name
    self.user.isa.first.funding_option.right_application.funding_opportunity.fund.name unless self.user.isa.first.funding_option.right_application.funding_opportunity.nil?
  end

  def user_identification_number
    self.user.identification_number unless self.user.nil?
  end

  def user_name
    self.user.name
  end

  def disbursement_case
    self.resource.disbursement_case
  end

  def user_email
    self.user.email
  end

  def user_contact_number
    self.user.contact_info.mobile
  end

  def funding_opportunity_full_room
    self.user.isa.first.funding_option.right_application.funding_opportunity.full_room
  end

  def institution_bank_acount_number
    self.user.funded_programs.last.institution.bank_account.map{|account| account.account_number}
  end

  def institution_bank_acount_account_case
    self.user.funded_programs.last.institution.bank_account.map{|account| account.account_case}
  end

  def institution_bank_acount_bank_name
    self.user.funded_programs.last.institution.bank_account.map{|account| account.bank_name}
  end

  def user_account_number
    self.user.bank_account.account_number unless self.user.bank_account.nil?
  end
  
  def institution_name
    funded_programs =  self.user.funded_programs
    if funded_programs.any?
      funded_programs.last.institution.name unless funded_programs.last.institution.nil?
    end
  end

  def user_account_case
    self.user.bank_account.account_case unless 	self.user.bank_account.nil?
  end

  def user_bank_name
    self.user.bank_account.bank_name unless self.user.bank_account.nil?
  end

  def requested_disbursement_value
    self.disbursement_request.disbursement_value unless self.disbursement_request.nil?
  end

  def requested_disbursement_value
    self.disbursement_request.disbursement_value unless self.disbursement_request.nil?
  end

  def requested_disbursement_date
    self.disbursement_request.created_at unless self.disbursement_request.nil?
  end

  def requested_disbursement_case
    if self.disbursement_request
      if self.disbursement_request.disbursement_case.present?
        self.disbursement_request.disbursement_case
      else
        self.disbursement_request.pending_changes.last.params['disbursement_case'] if  self.disbursement_request.pending_changes.any?
      end
    end
  end

  def real_disbursement_payment_amount
    self.disbursement_request.disbursement_match.sum(&:values) unless self.disbursement_request.nil?
  end	

  def payment_target
    self.disbursement_request.payment_target unless self.disbursement_request.nil?
  end

  def disbursement_payment_status
    self.disbursement_request.disbursement_payment.last.status unless self.disbursement_request.nil? || self.disbursement_request.disbursement_payment.last.nil?
  end

  def application_disbursement_associated_id
    self.resource_id
  end

  def self.send_email_for_pending_disbursement_application
    applications = Application.where(status: 'active',application_case: 'disbursement_request').where("created_at::date = ?", 5.days.ago)
    applications.each do |application|
      user = application.user
      SendEmailPendingDisbursementApplicationAsync.perform_async(user.id, application.id)
    end
  end
end
