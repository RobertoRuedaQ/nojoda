class Isa < ApplicationRecord
	# Academic Status
	#['academic_stop','drop_out','graduation_process','graduated','studing']

	# General Status
	# ['manual_activation','finalized_payments','out_of_the_fund','permanent_default','default','recovered_from_default','expelled','retired','ceded','inactive','active']

	# Income Status
	#['student_forbearance','grace_period','discretionary_forbearance','forcasted_income','breach_of_contract','forbearance','isa_income']      
	resourcify
	audited
  belongs_to :user, touch: true
  belongs_to :funding_option
  belongs_to :funding_opportunity
  belongs_to :student_academic_information
	belongs_to :employment_status_collection_trigger, class_name: "Collection", optional: true 
	has_one :fund_withdrawal, dependent: :destroy
	has_many :isa_status, dependent: :destroy
	has_many :disbursement, dependent: :destroy
	has_many :billing_document,->{kept.order(reference_date: :desc)}, dependent: :destroy
	has_many :not_organized_billing_document, class_name: 'BillingDocument', foreign_key: 'isa_id'
	has_many :billing_document_detail, dependent: :destroy
	has_many :payment_agreement, dependent: :destroy
	has_many :batch_details, dependent: :destroy
	has_many :payments, through: :billing_document, source: :payment
	has_many :payment_match, through: :payments, source: :payment_match
	has_many :isa_amendment, dependent: :destroy
	has_many :payment_match,as: :target_record
	has_many :document_payment_match, through: :not_organized_billing_document, source: :payment_match
	has_one :active_isa_amendment, ->{where(status: 'active')}
	has_one :cancellation_request, dependent: :destroy
	has_many :conciliation_information, dependent: :destroy
	has_many :conciliation_application, through: :conciliation_information, source: :application

	has_many :payed_disbursement,->{where(status: 'payed')}, through: :funding_option, source: :disbursement
	has_many :disbursement_cancellation, through: :payed_disbursement,source: :disbursement_cancellation
	has_one :cancellation_application, through: :cancellation_request, source: :application


	scope :active, ->{where(stored_general_status: Isa.active_for_collection,status: 'active')}
	scope :positive_nominal_payment,->{joins(:funding_option,[funding_option: :funding_option_config]).where(funding_options:{funding_option_configs: {name: 'nominal_payment'}})}

	scope :with_nominal_payment,->{active.positive_nominal_payment.where(stored_income_status: ['student_forbearance','grace_period','discretionary_forbearance','forbearance'] )}
	scope :with_payment, ->{active.where(stored_income_status: 'isa_income')}
	scope :with_forcasted_income_payment, ->{active.where(stored_income_status: 'forcasted_income')}
	scope :to_generate_billing_document, ->(fund_id){joins(funding_option: [application: [funding_opportunity: :fund]]).where(funding_options: {applications:{funding_opportunities: { fund_id: fund_id }}}).active}

	scope :active_isa,->{where(status: 'active').order(start_date: :desc).limit(1)}

	after_commit :update_isa_status, on: [:create, :update]
	after_commit :store_cached_summary_variables
	after_commit :update_dynamic_rate_config

	def store_cached_summary_variables
		self.update_column('repayment_total_number',self.repayment_total_number_logic)
		self.update_column('repayment_payed_number',self.repayment_payed_number_logic)
		self.update_column('payment_to_finalize_isa',self.payment_to_finalize_isa_logic)
	end

	def update_dynamic_rate_config
		PerformServiceAsync.perform_in(5.minutes, 'UpdateDynamicRateConfigService', self.id)
	end


	def total_cancellation
		self.funding_option.disbursement_cancellation.sum(:value)
	end


	def repayment_total_number_logic
		self.billing_document_detail.where(detail_case: 'repayment').sum(:payment_equivalency)
	end

	def repayment_payed_number_logic
		self.billing_document_detail.where(detail_case: 'repayment').sum(:equivalency_covered).round(1)
	end

	def payment_to_finalize_isa_logic
		isa_term = self.funding_option.isa_term
		return 0 if isa_term.nil?

		(isa_term.to_f - self.repayment_payed_number.to_f).round(2)
	end

	def total_payment_by_year year
		self.payment_match.joins(:billing_document_detail).where.not(billing_document_details: {detail_case: 'penalty'}).where(billing_document_details: {year: year}).sum(:value)
	end

	def total_payment_by_year_for_conciliation start_date, end_date
		# As students pay based on the income of the previous month, to get the information of income from the calendar year we need to sum the matches with details between February and January (Not January to December).

		adjusted_start_date = start_date.beginning_of_month + 1.month
		adjusted_end_date = end_date.beginning_of_month + 1.month
		PaymentMatch.joins(billing_document_detail: [billing_document_match: :billing_document]).where('billing_documents.isa_id = ?',self.id).where.not(billing_document_details: {detail_case: 'penalty'}).where(billing_document_details: {detail_case: ['repayment','nominal_payment']}).where('billing_document_details.reference_date >= ? AND billing_document_details.reference_date <= ?',adjusted_start_date, adjusted_end_date).sum(:value)
	end


	def show_after_graduation_cancellation_option
		self.pending_after_graduation_cancellation? && !self.cancellation_under_review?
	end


  def pending_after_graduation_cancellation?
    self.pending_after_graduation_cancellation.any?
  end


  def pending_after_graduation_cancellation
    self.cancellation_after_graduation_config.where.not(record_type: self.disbursement_cancellation.pluck(:cancellation_case)) 
  end


  def cancellation_under_review?
    self.cancellation_application.present? && self.cancellation_application.status == 'submitted'
  end


	def apply_cancellations_after_graduation
		if self.cancellation_request.graduation_date.present? && self.funded_major.graduation_date.nil?
			self.funded_major.update(graduation_date: self.cancellation_request.graduation_date)
		end
		general_after_graduation_cancellation_formula self.cancellation_after_graduation_config
		self.funding_option.touch
	end

  def cancellation_after_graduation_config
    self.cancellation_config.where(ejecution_type: 'graduation')
  end

  def cancellation_config
  	self.fund.cancellation_config
  end

  def general_after_graduation_cancellation_formula target_configs
  	target_configs = [] if target_configs.nil?
    target_configs.each do |cancellation|
      if self.cancellation_request.validate_cancellation_config cancellation
      	begin
	      	self.payed_disbursement.where(disbursement_case: cancellation.cancellation_type).each do |disbursement|
		        temp_cancellation =  disbursement.disbursement_cancellation.find_or_create_by(cancellation_config_id: cancellation.id, status: 'active')
		        expected_cancellation = [[(disbursement.adjusted_student_value * cancellation.cancellation_percentage.to_f / 100).round, 
		                                        (disbursement.adjusted_student_value * cancellation.max_general.to_f / 100 - disbursement.disbursement_cancellation.where.not(cancellation_config_id: cancellation.id).sum(:value)).round].min,0].max
		        if temp_cancellation.value.to_f != expected_cancellation
		          temp_cancellation.update({cancellation_case: cancellation.record_type, value: expected_cancellation})
		        end
		    end
      	rescue
      		puts "Error in general_after_graduation_cancellation_formula process"
      	end
      else
      	## REVIEW
        temp_cancellation =  disbursement.first.disbursement_cancellation.find_by(cancellation_config_id: cancellation.id, status: 'active')
        if temp_cancellation.present?
          temp_cancellation.destroy
        end
      end
    end
  end


	def origination
		self.funding_opportunity.origination
	end


	def total_pending_questionnaires
		UserQuestionnaire.joins(:questionnaire,:application).where(applications: {status: 'submitted'},questionnaires: {category: "review"},status: ['active','ongoing'],user_id: self.user_id).distinct
	end



	def in_termination_agreement?
		self.payment_agreement.where(agreement_case: 'termination',status: 'valid').count > 0
	end

	def manage_document_generation batch
		begin
			self.generate_billing_document batch
			target_detail = self.batch_details.find_by(payment_batch_id: batch.id)
			if target_detail.nil?
				target_detail = BatchDetail.create(isa_id: self.id, payment_batch_id: batch.id)
			end
			target_detail.update(status: 'done')
		rescue Exception => e
			target_detail = self.batch_details.find_by(payment_batch_id: batch.id)
			if target_detail.nil?
				target_detail = BatchDetail.create(isa_id: self.id, payment_batch_id: batch.id)
			end
			target_detail.update(status: 'error',error_text: e.message, error_backlog: e.backtrace.inspect)
		end

	end

	def legacy_general_status
		self.user.legacy_status.general_status
	end
	def legacy_work_status
		self.user.legacy_status.work_status
	end
	def legacy_academic_status
		self.user.legacy_status.academic_status
	end

	def legacy_payment_status
		self.user.legacy_status.payment_status
	end


	def payments_to_isa
		payment_ids = Payment.joins(:payment_match,billing_document: :isa).where.not(payment_matches: {target_record_type: 'DisbursementRequest'}).where(billing_documents: {isas: {id: self.id}}).ids.uniq
		Payment.where(id: payment_ids)
	end

	def payments_repayments
		payment_ids = Payment.joins(:payment_match,billing_document: :isa).where(payment_matches: {target_record_type: 'BillingDocumentDetail'}).where(billing_documents: {isas: {id: self.id}}).ids.uniq
		Payment.where(id: payment_ids)
	end

	def activation_date
		target_status = self.isa_status.where(status_case: "general_status",status: Isa.active_for_collection).order(start_date: :asc).first
		if target_status.nil?
			result = nil
		else
			result = target_status.start_date
		end
		return result
	end 

	def fund_regular_exit_date
		target_status = self.isa_status.where(status_case: "general_status",status: Isa.regular_fund_exit).order(start_date: :asc).first
		if target_status.nil?
			result = nil
		else
			result = target_status.start_date
		end
		return result
	end


 def funding_opportunity_name
  self.funding_opportunity.name
 end

 def direct_funding_opportunity
 	self.funding_option.right_application.resource
 end


 def fund_name
  self.fund.name
 end


 	def covid_payment_agreement
		PaymentAgreement.includes(payment: [{payment_match: :billing_document_detail}]).find_by(agreement_case: 'covid_emergency',billing_document_id: self.billing_document.ids).distinct
 	end


	def active_payment_agreements
		case self.stored_income_status
		when 'covid_agreement'
			self.payment_agreement.where(agreement_case: 'covid_emergency',status: "valid")
		when 'termination_agreement'
			termination_agreement = self.payment_agreement.find_by(agreement_case: 'termination',status: "valid")
			self.payment_agreement.where('status = ? AND start_date >= ?', 'valid',termination_agreement.start_date)
		else
			self.payment_agreement.where(status: "valid")
		end
	end

	def self.historic_student
		['finalized_payments','out_of_the_fund','permanent_default','default','ceded','active']
	end

	def self.regular_fund_exit
		['finalized_payments','out_of_the_fund']
	end

	def self.active_for_collection
		['manual_activation','recovered_from_default','expelled','retired','active', 'final_conciliation']
	end

	def active_for_collection?
		Isa.active_for_collection.include?(self.stored_general_status)
	end

	def self.general_status_options
		['manual_activation','finalized_payments','out_of_the_fund','permanent_default','default','recovered_from_default','expelled','retired','ceded','inactive','active']
	end

	def total_destroy
		self.update(status: 'deleting')
		self.isa_status.destroy_all
		self.disbursement.update_all(isa_id: nil)
		self.billing_document.destroy_all
		self.billing_document_detail.destroy_all
		self.destroy
	end

	def student_name
		student = User.cached_find(self.user_id)
		student.name
	end

  def user_name
    Rails.cache.fetch(['isa_user_name',self.id]){user.name}
  end

	def status_for_nominal_payment
		['student_forbearance','grace_period','discretionary_forbearance','forbearance', 'breach_of_contract']
	end

	def status_for_isa_repayment
		['isa_income']
	end

	def inflation_factor
		Ipc.factor(self.inflation_adjustment_date, self.country.id)
	end

	def country
		self.funding_opportunity.fund.company.country
	end

	def nominal_payment
		record = self.funding_option.funding_option_config.find_by_name('nominal_payment')
		if !record.nil?
			@result = (record.value.to_f * self.inflation_factor)
		end
		return self.adjust_value @result
	end

	def nominal_payment?
		self.nominal_payment > 0
	end


	

	def active_billing_document
		self.billing_document.find_by_active(true)
	end

	def last_created_billing_document
		self.billing_document.order(reference_date: :desc).limit(1).first
	end

	def pending_billing_documents year, month
		self.billing_document_detail.pending_details(year,month)
	end

	def current_percentage
		if self.stored_academic_status == 'studing'
			target_percentage = self.funding_option.percentage_student
		else
			target_percentage = self.funding_option.percentage_graduated
		end
		return target_percentage
	end

	def payment_value billing_document_id = nil
		if self.stored_income_status == 'isa_income'
			result = (self.user.total_income(billing_document_id) * self.current_percentage.to_f / 100).floor(1)
		else
			result = 0
		end
		return self.adjust_value result
	end

	def payment_adjustment
		result = self.funding_opportunity.fund.company.min_unid_collection.to_f
		if result == 0
			result = 1
		end
		return result
	end

	def adjust_value target_value
		(target_value.to_f / self.payment_adjustment).floor * self.payment_adjustment
	end


	def covid_due_date?
		billing_document_ids = self.billing_document.joins(:covid_emergency).where(covid_emergencies: {option: 'due_date'}).ids
		if billing_document_ids.count > 0
			covid = CovidEmergency.find_by(billing_document_id: billing_document_ids, option: 'due_date')
			if covid.nil?
				result = false
			else
				if covid.start_date <= Time.now.to_date && covid.end_date >= Time.now.to_date
					result = true
				else
					result = false
				end
			end
		else
			result = false
		end
		return result
	end

	def due_to_date batch
		target_date = self.fund.timely_payment_day
		max_day = "#{batch.year}-#{batch.month}-1".to_date.end_of_month.day
		if !self.covid_due_date?
			result = "#{batch.year}-#{batch.month}-#{[[self.fund.timely_payment_day.to_i,max_day].min,1].max}".to_date
		else
			result = "#{batch.year}-#{batch.month}-#{max_day}".to_date
		end
		return result
	end

	def generate_billing_document batch
		if batch.year.present? && batch.month.present?
			if self.stored_income_status == 'covid_agreement' && covid_season?(batch)
				detail_case = 'payment_agreement'
			elsif self.stored_income_status == 'termination_agreement'
				detail_case = 'payment_agreement'
			elsif status_for_nominal_payment.include?(self.stored_income_status)
				payment_value = self.nominal_payment
				detail_case = 'nominal_payment'
			elsif status_for_isa_repayment.include?(self.stored_income_status)
				detail_case = 'repayment'
			else
				payment_value = 0
				detail_case = 'no_payment'
			end

			billing_status = batch.status == 'finale_close' ? 'active' : 'pending'

			billing_document = self.billing_document.find_by(year: batch.year, month: batch.month)
			if billing_document.nil?
				billing_document = BillingDocument.create({year: batch.year, month: batch.month,payment_batch_id: batch.id,status: billing_status,isa_id: self.id,reference_date: "#{batch.year}-#{batch.month}-1".to_date,due_to_date: self.due_to_date(batch),income_case: self.stored_income_status,income_value: payment_value, percentage_case: self.stored_academic_status, percentage_value: self.current_percentage})
			else
				billing_document.update({due_to_date: self.due_to_date(batch),income_case: self.stored_income_status,income_value: payment_value, percentage_case: self.stored_academic_status, percentage_value: self.current_percentage})
			end

			if detail_case == 'repayment'
				payment_value = self.payment_value(billing_document.id)
				destroy_details_case('nominal_payment', batch)
			elsif detail_case == 'nominal_payment'
				destroy_details_case('repayment', batch)
			end

			payment_value = payment_value ? payment_value.floor(2) : payment_value

			BillingDocumentDetail.where(isa_id: self.id, month: batch.month, year: batch.year, status: "pending").where.not(detail_case: detail_case, migrated: true).destroy_all
			
			BillingDocumentMatch.where({resource_type: 'BillingDocument', resource_id: billing_document.id}).destroy_all

			if self.stored_income_status != 'no_payment'
				#value_to_cap = self.funding_option.value_to_cap.to_f
				#payment_value = value_to_cap if value_to_cap < payment_value.to_f

				to_finalize = self.payment_to_finalize_isa

				self.active_payment_agreements.each do |agreement|
					if agreement.agreement_case == 'covid_emergency'
						next unless covid_season?(batch)
					end

					next unless agreement.start_date <= batch.billing_documents_date 
					
					if (self.stored_academic_status != 'graduated' && to_finalize <= 0) || (to_finalize > 0)
						agreement_detail = BillingDocumentDetail.find_by(isa_id: self.id, year: batch.year, month: batch.month, detail_case: 'payment_agreement',payment_agreement_id: agreement.id)
						
						if agreement_detail.nil?
							agreement_detail = BillingDocumentDetail.create({isa_id: self.id, year: batch.year, month: batch.month, status: 'pending',payment_equivalency: 1, value: agreement.cuota_value.floor(2),reference_date: "#{batch.year}-#{batch.month}-1".to_date,detail_case: 'payment_agreement',payment_agreement_id: agreement.id})
						else
							agreement_detail.update({value: agreement.cuota_value.floor(2)})
						end
					end
				end


				if self.stored_income_status != 'just_agreement' && detail_case != 'payment_agreement'
				
					#if (value_to_cap > 0 && to_finalize > 0) || (self.stored_academic_status != 'graduated' && to_finalize <= 0)
					billing_document_detail = BillingDocumentDetail.find_by(isa_id: self.id, year: batch.year, month: batch.month,detail_case: detail_case)
					if billing_document_detail.nil? && payment_value > 0
						billing_document_detail = BillingDocumentDetail.create({isa_id: self.id, year: batch.year, month: batch.month, status: 'pending',payment_equivalency: 1, value: payment_value,reference_date: "#{batch.year}-#{batch.month}-1".to_date,detail_case: detail_case})
					elsif !billing_document_detail.nil? && payment_value > 0
						billing_document_detail.update({value: payment_value})
					end
					#end
				end


				all_details = 	self.pending_billing_documents(billing_document.year,billing_document.month)
				all_details.each do |detail|
					if detail.detail_case != "penalty"
						target_match = detail.billing_document_match.find_by(resource_type: 'BillingDocument', resource_id: billing_document.id)
						if target_match.nil?
							BillingDocumentMatch.create({resource_type: 'BillingDocument', resource_id: billing_document.id,billing_document_detail_id: detail.id})
						end
					end
				end
			end

			available_excess = self.user.payment_excess.includes([:payment]).where('value > 0')

			available_excess.each do |excess|
				excess.payment.match_payments( billing_document_id: billing_document.id)
			end
		end

	end

	def destroy_details_case(detail_case, batch)
		BillingDocumentDetail.where(isa_id: self.id, month: batch.month, year: batch.year).where(detail_case: detail_case).destroy_all
	end


	def current_status status_case
		IsaStatus.active_status_1(status_case,self.id).or(IsaStatus.active_status_2(status_case,self.id))
	end

	def fund
		self.funding_opportunity.fund
	end


	def active_status status_case
		self.current_status(status_case).pluck(:status)
	end

	def potential_status status_case
		IsaStatus.potential_status_1(status_case,self.id).or(IsaStatus.potential_status_2(status_case,self.id)).pluck(:status)
	end



	def stored_academic_status
		if !self.student_academic_information.nil? 
			self.student_academic_information.stored_academic_information
		end
	end


	def requested_disbursements
		self.funding_option.disbursement.where(status: 'requesting')
	end


	def general_status
		self.active_status 'general_status'
	end

	def general_potential_status
		self.potential_status 'general_status'
	end

	def covid_season?(batch)
		batch.year == 2020 && batch.month < 7
	end

	def general_status_logic
		if self.general_potential_status.include?('manual_activation')
			result = 'manual_activation'
		elsif self.general_potential_status.include?('finalized_payments')
			result = 'finalized_payments'
		elsif self.general_potential_status.include?('out_of_the_fund')
			result = 'out_of_the_fund'
		elsif self.general_potential_status.include?('permanent_default')
			result = 'permanent_default'
		elsif self.general_potential_status.include?('default')
			result = 'default'
		elsif self.general_potential_status.include?('recovered_from_default')
			result = 'recovered_from_default'
		elsif self.general_potential_status.include?('expelled')
			result = 'expelled'
		elsif self.general_potential_status.include?('retired')
			result = 'retired'
		elsif self.general_potential_status.include?('ceded')
			result = 'ceded'
		elsif self.disbursement.active_disbursement.count == 0
			result = 'inactive'
		elsif self.general_potential_status.include?('final_conciliation')
			result = 'final_conciliation'
		else
			result = 'active'
		end
		return result
	end

	def max_forbearance_months
		target_config = self.funding_option.funding_option_config.find_by_name('unemployment_months')
		if target_config.nil?
			result = 0
		else
			result = target_config.value
		end
		return (result + self.discretionary_forbearance_months)
	end

	def discretionary_forbearance_months
		target_status = self.isa_status.where(status: 'discretionary_forbearance', phase: ['active','deactivated']).where.not(start_date: nil)
		target_status.map{|f| months_between f.start_date,(f.end_date.nil? ? Time.now.to_date : f.end_date)}.inject(:+).to_i
	end

	def current_forbearance_months
		result = 0
		forbearance_records = self.isa_status.where(phase: ['active','deactivated'],status_case: 'income_status',status: 'forbearance')
		forbearance_records.each do |forbearance|
			end_date = forbearance.end_date.nil? ? Time.now.to_date : forbearance.end_date
			result += months_between forbearance.start_date, end_date
		end
		return result
	end


	def threshold
		threshold_excep = threshold_exception
		return threshold_excep unless threshold_excep.nil?
		
		target_config = self.funding_option.funding_option_config.find_by_name('threshold')
		if target_config.nil?
			result = 0
		else
			result = target_config.value
		end
	end

	def threshold_exception
		target_config = self.funding_option.funding_option_config.find_by_name('threshold_exception')
		target_config.value unless target_config.nil?
	end


	def student_percentage
		self.funding_option.percentage_student.to_f
	end

	def graduated_percentaje
		self.funding_option.percentage_graduated.to_f
	end

	def income_status
		self.active_status 'income_status'
	end

	def income_potential_status
		self.potential_status 'income_status'
	end

	def identification_number
		self.user.identification_number
	end

	def income_status_logic
		if self.income_potential_status.include?('covid_agreement')
			result = 'covid_agreement'
		elsif self.income_potential_status.include?('no_payment') || (self.stored_general_status == 'finalized_payments')
			result = 'no_payment'
		elsif self.in_termination_agreement?
			result = 'termination_agreement'
		elsif self.income_potential_status.include?('just_agreement')
			result = 'just_agreement'
		elsif ['studing','graduation_process','academic_stop'].include?(self.stored_academic_status) && self.student_percentage == 0
			result = 'student_forbearance'
		elsif self.income_potential_status.include?('grace_period')
			result = 'grace_period'
		elsif self.income_potential_status.include?('discretionary_forbearance')
			result = 'discretionary_forbearance'
		elsif self.max_forbearance_months.to_i < self.current_forbearance_months.to_i
			if self.fund.forcasted_salary_clause
				result = 'forcasted_income'
			else
				result = 'breach_of_contract'
			end
		elsif self.threshold > self.current_total_income || self.current_total_income == 0
			result = 'forbearance'
		else
			result = 'isa_income'
		end
		return result
	end


	def set_employed_without_certificate(collection_id)
		set_employment_status(IsaStatus::EMPLOYED_WITHOUT_CERTIFICATE, collection_id)
	end

	def set_unemployed(collection_id)
		set_employment_status(IsaStatus::UNEMPLOYED, collection_id)
	end

	def set_employment_status(new_status, collection_id = nil)
		self.update(
			stored_employment_status: new_status, 
			employment_status_collection_trigger_id: collection_id
		)
	end

	def employment_status_logic
		if user.total_income > 0
			self.update(employment_status_collection_trigger_id: nil) if self.employment_status_collection_trigger.present?
			if valid_income?
				result = IsaStatus::EMPLOYED
			else
				result = IsaStatus::EMPLOYED_WITHOUT_VALID_INCOME
			end
			if self.user.has_active_presumptive_income?
				result = IsaStatus::EMPLOYED_WITH_PRESUMPTIVE_INCOME
			end
		elsif
			if self.stored_employment_status == IsaStatus::EMPLOYED_WITHOUT_CERTIFICATE
				result = self.stored_employment_status
			else
				result = IsaStatus::UNEMPLOYED
			end
		end
		
		return result
	end


	def valid_income?
		total_income = self.user.total_income
		
		total_income >= self.threshold.to_f && total_income >= self.threshold_exception.to_f
	end

	def employment_status
		self.active_status 'employment_status'
	end

	def employment_potential_status
		self.potential_status 'employment_status'
	end

	def current_total_income
		billing_document = self.billing_document.find_by(year: Time.now.year, month: Time.now.month)
		if billing_document.nil?
			result = self.user.total_income
		else
			result = self.user.total_income(billing_document.id)
		end
		return result
	end

	def payment_status
		self.active_status 'payment_status'
	end

	def payment_potential_status
		self.potential_status 'payment_status'
	end

	def details_in_arrears
		if !self.active_billing_document.nil?
			self.active_billing_document.billing_document_detail.where.not(status: ['payed','adjusted']).where('reference_date < ?',self.active_billing_document.reference_date )
		end
	end

	def months_in_arrears

		@first_date = self.details_in_arrears.pluck(:reference_date).min if !self.details_in_arrears.nil?
		if @first_date.nil?
			result = 0
		else
			result = months_between @first_date, Time.now.to_date 
		end
		return result
	end

	def payments_in_arrears
		self.details_in_arrears.sum(:payment_equivalencyq)
	end

	def payment_status_logic
		if ['default','permanent_default'].include?(self.stored_general_status)
			result = 'default'
		elsif self.months_in_arrears > 0
			result = "arrears_#{self.months_in_arrears.to_i * 30}"
		else
			result = 'up_to_date'
		end
		return result
	end

	def update_isa_status
		puts 'update_isa_status'
		#General Status
			if self.status != 'deleting'	
				default_status_cases = ['general_status','income_status','payment_status', 'employment_status' ]
				default_status_cases.each do |status_case|
					if eval(status_case).first != self.send("#{status_case}_logic")
						self.set_new_status( status_case,self.send("#{status_case}_logic"), Time.now.to_date) 
						eval("self.update(stored_#{status_case}: self.send('#{status_case}_logic'))")
					elsif self.send("stored_#{status_case}") != self.send("#{status_case}_logic")
						eval("self.update(stored_#{status_case}: self.send('#{status_case}_logic'))")
					end
				end
			end
	end

	def funded_major
		
		self.student_academic_information
	end

	def set_new_status status_case,status, start_date, end_date = nil
		# The IsaStatus creation triggers the deactivation of any other status in the same case for this Isa
		new_status = IsaStatus.create(isa_id: self.id,status_case: status_case,status: status,start_date: start_date,end_date: end_date,phase: 'active')
	end


	def verify_status status_case,status

	end

	def total_amount_payed_by_student
		self.billing_document_detail.select{|b| b.status == 'payed' && b.detail_case != 'penalty'}.sum(&:applied_value)
	end
	
	# Pending: Change end date with finalize contract action



end
